require 'mp.options'
function copy_to_music_handler()
	local handle = io.popen("echo $MUSIC")
	-- Replace dst_dir with your chosen directory
	dst_dir = string.gsub(handle:read("*a"), "^%s*(.-)%s*$", "%1") -- Capture output and trim string
	handle:close()

	local utils = require 'mp.utils'
	file_name = mp.get_property('path')
	working_dir = mp.get_property('working-directory')
	file_path = utils.join_path(working_dir, file_name)
	duplicate_counter = 1
	dst_file_name = file_name
	dst_file_path = dst_dir .. "/" .. dst_file_name
	-- Handle duplicate files by adding (#) before the extension, where # is a number of how many duplicates there are
	while os.execute("test -f " .. "\"" .. dst_file_path .. "\"")
	do
		extension = file_name:match("^.+(%..+)$")
        file_name_without_extension = string.gsub(file_name, extension, '')
        dst_file_name = file_name_without_extension .. " (".. duplicate_counter .. ")" .. extension
		dst_file_path = dst_dir .. "/" .. dst_file_name
		duplicate_counter = duplicate_counter + 1
	end
	os.execute("cp " .. "\"" .. file_path .. "\"" .. " \"" .. dst_file_path .. "\"") -- Replace $MUSIC with your music folder if you like. Personally I like to export $MUSIC in my OS
	mp.osd_message("Copied file to your music folder. Playing next entry in the playlist")
    mp.command("playlist_next")
end
mp.add_key_binding("ctrl+m","copy_to_music",copy_to_music_handler)
