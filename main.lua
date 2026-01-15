local M = {}

function M:peek(job)
	ya.err("pickle plugin called for: " .. tostring(job.file.url))
	local child = Command("python3")
		:arg({
			"-c",
			[[
import pickle
import pprint
import sys

try:
    with open(sys.argv[1], 'rb') as f:
        data = pickle.load(f)
    
    print(f"Type: {type(data).__name__}")
    print("─" * 40)
    
    pp = pprint.PrettyPrinter(indent=2, width=80, depth=4)
    pp.pprint(data)
except Exception as e:
    print(f"Error reading pickle file: {e}")
]],
			tostring(job.file.url),
		})
		:stdout(Command.PIPED)
		:stderr(Command.PIPED)
		:spawn()

	if not child then
		ya.err("Failed to spawn python3")
		return
	end

	local limit = job.area.h
	local i, lines = 0, ""
	repeat
		local next, event = child:read_line()
		if event == 1 then
			ya.err("Error reading from python3")
			return
		elseif event ~= 0 then
			break
		end

		i = i + 1
		if i > job.skip then
			lines = lines .. next
		end
	until i >= job.skip + limit

	child:start_kill()
	if job.skip > 0 and i < job.skip + limit then
		ya.emit("peek", { math.max(0, i - limit), only_if = job.file.url, upper_bound = true })
	else
		ya.preview_widget(job, ui.Text.parse(lines):area(job.area))
	end
end

function M:seek(job)
	require("code"):seek(job)
end

return M
