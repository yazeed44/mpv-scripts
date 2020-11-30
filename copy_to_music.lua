require 'mp.options'
function copy_to_music_handler()
	local handle = io.popen("echo $MUSIC")
	-- Replace dst_dir with your chosen directory
	local dst_dir = string.gsub(handle:read("*a"), "^%s*(.-)%s*$", "%1") -- Capture output and trim string
	handle:close()	
	local src_file_name = mp.get_property('filename')
	local src_file_path = mp.get_property('path')
	local dst_file_name = src_file_name
	local dst_file_path = dst_dir .. "/" .. dst_file_name
	
	local duplicate_counter = 1
	-- Handle duplicate files by adding (#) before the extension, where # is a number of how many duplicates there are
	while os.execute("test -f " .. "\"" .. dst_file_path .. "\"")
	do
		local extension = src_file_name:match("^.+(%..+)$")
        local file_name_without_extension = string.gsub(src_file_name, extension, '')
        dst_file_name = file_name_without_extension .. " (".. duplicate_counter .. ")" .. extension
		dst_file_path = dst_dir .. "/" .. dst_file_name
		duplicate_counter = duplicate_counter + 1
	end
	local cp_cmd = "cp " .. "\"" .. src_file_path .. "\"" .. " \"" .. dst_file_path .. "\""
	os.execute(cp_cmd)
	mp.osd_message("Copied file to your music folder. Playing next entry in the playlist")
    mp.command("playlist_next")
end
mp.add_key_binding("ctrl+m","copy_to_music",copy_to_music_handler)
