-- Credit goes to the JToH dev team

local userinput = game:GetService("UserInputService")

local plr = game.Players.LocalPlayer

function flip()
	local char = plr.Character
	if char then
		local hrp = char:FindFirstChild("Torso")
		if hrp then
			local touch = hrp:FindFirstChild("TouchInterest")
			if not touch then
				hrp.Touched:Connect(function() end)
			end
			for _, t in pairs(hrp:GetTouchingParts()) do
				if t:FindFirstChild("CanFlip") and t.CanCollide then
					local offsetFromPart = t.CFrame:ToObjectSpace(hrp.CFrame)
					local cframeSet = t
					if t:FindFirstChild("TeleToObject") then
						cframeSet = t.TeleToObject.Value
					end
					hrp.CFrame = (cframeSet.CFrame * CFrame.Angles(0, math.pi, 0)) * offsetFromPart
					local snd = script.DoNotChange:Clone()
					snd.Parent = cframeSet
					snd:Play()
					game.Debris:AddItem(snd, 0.8)
					break
				end
			end
		end
	end
end

userinput.InputBegan:Connect(function(inputObj, proc)
	if not proc then
		local keycode = inputObj.KeyCode
		if keycode == Enum.KeyCode.F or keycode == Enum.KeyCode.ButtonX then
			flip()
		end
	end
end)

if userinput.TouchEnabled and not userinput.KeyboardEnabled then
	userinput.TouchTapInWorld:Connect(function(touches, proc)
		if not proc then
			flip()
		end
	end)
end
