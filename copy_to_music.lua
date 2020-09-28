require 'mp.options'
function copy_to_music_handler()
	local utils = require 'mp.utils'
	file_name = mp.get_property('path')
	working_dir = mp.get_property('working-directory')
	file_path = utils.join_path(working_dir, file_name)
	os.execute("cp " .. "\"" .. file_path .. "\"" .. " $MUSIC") -- Replace $MUSIC with your music folder if you like. Personally I like to export $MUSIC in my OS
	mp.osd_message("Copied file to your music folder. Playing next entry in the playlist")
    mp.command("playlist_next")
end
mp.add_key_binding("ctrl+m","copy_to_music",copy_to_music_handler)
