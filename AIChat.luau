local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")
local TextChatService = game:GetService("TextChatService")
local HttpService = game:GetService("HttpService")

local config = getgenv().AIConfig
if not (config and config.BaseUrl and config.APIKey and config.Model) then
  error("AI配置错误!")
end

local BASEURL = config.BaseUrl
local APIKEY = config.APIKey
local MODEL = config.Model
local COOLDOWN = config.Cooldown or 10

SYSTEM_PROMPT = [[You are a real player currently playing Roblox, and your player name is "%s". Please respond to other players' questions in the game chat in a natural, friendly manner as an ordinary player. Follow these guidelines:
- Keep your responses **short and concise** – use brief sentences or even fragments, just like a typical player in a fast-paced game;
- Use a relaxed, colloquial online chat style (you may include common Roblox slang like "gg", "ez", "oof", etc.);
- Your responses should be relevant to the current game context (you are playing on the map: **[%s]**) – the tone should fit a player's perspective, not mechanical or official;
- Do not actively mention that you are an AI or a language model;
- If a question goes beyond general game knowledge or involves sensitive real-life information, politely say you're not sure or change the subject;
- Maintain a positive, friendly attitude and avoid provoking or mocking others.
- **User context format:** Each incoming user message is prefixed with `"[username] context"` to indicate who sent it. Use this to refer to players by name when appropriate.
- **Language:** Always respond in the **same language** the user used in their message. If they ask in Chinese, reply in Chinese; if in English, reply in English, etc.]]
string.format(SYSTEM_PROMPT, Players.LocalPlayer.Name, MarketplaceService:GetProductInfoAsync(game.PlaceId).Name)

local histroy = {
  {
    role = "system",
    content = SYSTEM_PROMPT
  }
}

local function chatMessage(str)
  TextChatService.TextChannels.RBXGeneral:SendAsync(tostring(str))
end

local function handleMessage(msg)
  local result = HttpService:RequestAsync({
    Url = BASEURL .. "/chat/completions",
    Method = "POST",
    Headers = {
      Authorization = "Bearer " .. APIKEY
    },
    Body = HttpService:JSONEncode({
      model = MODEL,
      temperature = 0.7,
      messages = histroy
    })
  })
  if result.Success then
    result = HttpService:JSONDecode(result.Body)
    local reply = result.choices[1].message.content
    table.insert(histroy, {
      role = "assistant",
      content = reply
    })
    print("[AI] " .. reply)
    chatMessage(reply)
  else
    error(string.format("[%s %s] 请求AI错误!", tostring(result.StatusCode), result.StatusMessage))
  end
end

local cooldown = tick()
getgenv().aichat = TextChatService.MessageReceived:Connect(function(msg)
  if Players:GetPlayerByUserId(msg.TextSource.UserId) == Players.LocalPlayer then
    return
  end
  table.insert(histroy, {
    role = "user",
    content = string.format("[%s] %s", Players:GetPlayerByUserId(msg.TextSource.UserId).Name, msg.Text)
  })
  print(histroy[#histroy].content)
  if tick() - cooldown > COOLDOWN then
    cooldown = tick()
    handleMessage(msg)
  end
end)
