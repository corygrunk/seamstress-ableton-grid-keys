--- ableton control surface
--
-- Note MIDI happens on channel 1
-- Control MIDI happens on channel 6
--
-- TODO: Add toggles and momentary lights
-- TODO: Need formatter to be supported for adding a parameter
--       in order to display the note name in the params page

local MusicUtil = require "musicutil"
local note_display_name = '--'

g = grid.connect() -- if no argument is provided, defaults to port 1
grid_connected = true
Midi = midi.connect(1)

scale_names = {}
notes = {} -- this is the table that holds the scales' notes

function init()

  for i = 1, #MusicUtil.SCALES do table.insert(scale_names, MusicUtil.SCALES[i].name) end

  params:add_separator('Scale Options')
  -- setting root notes using params
  params:add{
    type = "number", 
    id = "root_note", 
    name = "root note",
    min = 0, max = 127, default = 24, 
    formatter = function(param) return MusicUtil.note_num_to_name(param:get(), true) end,
    action = function() build_scale() end
  } -- by employing build_scale() here, we update the scale

  -- setting scale type using params
  params:add{
    type = "option", 
    id = "scale", 
    name = "scale",
    options = scale_names, default = 5,
    action = function() build_scale() end
  } -- by employing build_scale() here, we update the scale

  build_scale() -- builds initial scale

  midi:connect(1)

  grid_dirty = true -- initialize with a redraw
  screen_dirty = true -- initialize with a redraw
  clock.run(grid_redraw_clock) -- start the grid redraw clock
end


function build_scale()
  notes = MusicUtil.generate_scale(params:get("root_note"), params:get("scale"), 6)
  for i = 1, 64 do
    table.insert(notes, notes[i])
  end
end

function play_note(note)
  Midi:note_on(note, 96, 1)
  note_display_name = MusicUtil.note_num_to_name(note)
  screen_dirty = true
end

function stop_note(note)
  Midi:note_off(note, 96, 1)
end

-- BUTTON PRESSES
function g.key(x,y,z)

  -- drum buttons
  for i = 1, 8 do
    if z == 1 then
      if y == 1 then if x == 3 then play_note(56) end end
      if y == 1 then if x == 4 then play_note(57) end end
      if y == 1 then if x == 5 then play_note(58) end end
      if y == 1 then if x == 6 then play_note(59) end end
      if y == 2 then if x == 3 then play_note(52) end end
      if y == 2 then if x == 4 then play_note(53) end end
      if y == 2 then if x == 5 then play_note(54) end end
      if y == 2 then if x == 6 then play_note(55) end end
      if y == 3 then if x == 3 then play_note(48) end end
      if y == 3 then if x == 4 then play_note(49) end end
      if y == 3 then if x == 5 then play_note(50) end end
      if y == 3 then if x == 6 then play_note(51) end end
      if y == 4 then if x == 3 then play_note(44) end end
      if y == 4 then if x == 4 then play_note(45) end end
      if y == 4 then if x == 5 then play_note(46) end end
      if y == 4 then if x == 6 then play_note(47) end end
      if y == 5 then if x == 3 then play_note(40) end end
      if y == 5 then if x == 4 then play_note(41) end end
      if y == 5 then if x == 5 then play_note(42) end end
      if y == 5 then if x == 6 then play_note(43) end end
      if y == 6 then if x == 3 then play_note(36) end end
      if y == 6 then if x == 4 then play_note(37) end end
      if y == 6 then if x == 5 then play_note(38) end end
      if y == 6 then if x == 6 then play_note(39) end end
      -- if y == 7 then if x == 3 then play_note(32) end end
      -- if y == 7 then if x == 4 then play_note(33) end end
      -- if y == 7 then if x == 5 then play_note(34) end end
      -- if y == 8 then if x == 6 then play_note(35) end end
      -- if y == 8 then if x == 3 then play_note(28) end end
      -- if y == 8 then if x == 4 then play_note(29) end end
      -- if y == 8 then if x == 5 then play_note(30) end end
      -- if y == 8 then if x == 6 then play_note(31) end end
    else
      if y == 1 then if x == 3 then stop_note(56) end end
      if y == 1 then if x == 4 then stop_note(57) end end
      if y == 1 then if x == 5 then stop_note(58) end end
      if y == 1 then if x == 6 then stop_note(59) end end
      if y == 2 then if x == 3 then stop_note(52) end end
      if y == 2 then if x == 4 then stop_note(53) end end
      if y == 2 then if x == 5 then stop_note(54) end end
      if y == 2 then if x == 6 then stop_note(55) end end
      if y == 3 then if x == 3 then stop_note(48) end end
      if y == 3 then if x == 4 then stop_note(49) end end
      if y == 3 then if x == 5 then stop_note(50) end end
      if y == 3 then if x == 6 then stop_note(51) end end
      if y == 4 then if x == 3 then stop_note(44) end end
      if y == 4 then if x == 4 then stop_note(45) end end
      if y == 4 then if x == 5 then stop_note(46) end end
      if y == 4 then if x == 6 then stop_note(47) end end
      if y == 5 then if x == 3 then stop_note(40) end end
      if y == 5 then if x == 4 then stop_note(41) end end
      if y == 5 then if x == 5 then stop_note(42) end end
      if y == 5 then if x == 6 then stop_note(43) end end
      if y == 6 then if x == 3 then stop_note(36) end end
      if y == 6 then if x == 4 then stop_note(37) end end
      if y == 6 then if x == 5 then stop_note(38) end end
      if y == 6 then if x == 6 then stop_note(39) end end
      -- if y == 7 then if x == 3 then stop_note(32) end end
      -- if y == 7 then if x == 4 then stop_note(33) end end
      -- if y == 7 then if x == 5 then stop_note(34) end end
      -- if y == 8 then if x == 6 then stop_note(35) end end
      -- if y == 8 then if x == 3 then stop_note(28) end end
      -- if y == 8 then if x == 4 then stop_note(29) end end
      -- if y == 8 then if x == 5 then stop_note(30) end end
      -- if y == 8 then if x == 6 then stop_note(31) end end
    end
  end
  -- live play buttons
  for i = 1, 8 do
    if z == 1 then
      if y == 8 then if x == i + 8 then play_note(notes[i + 7]) end end
      if y == 7 then if x == i + 8 then play_note(notes[i + 10]) end end
      if y == 6 then if x == i + 8 then play_note(notes[i + 13]) end end
      if y == 5 then if x == i + 8 then play_note(notes[i + 16]) end end
      if y == 4 then if x == i + 8 then play_note(notes[i + 19]) end end
      if y == 3 then if x == i + 8 then play_note(notes[i + 22]) end end
      if y == 2 then if x == i + 8 then play_note(notes[i + 25]) end end
      if y == 1 then if x == i + 8 then play_note(notes[i + 28]) end end
    else
      if y == 8 then if x == i + 8 then stop_note(notes[i + 7]) end end
      if y == 7 then if x == i + 8 then stop_note(notes[i + 10]) end end
      if y == 6 then if x == i + 8 then stop_note(notes[i + 13]) end end
      if y == 5 then if x == i + 8 then stop_note(notes[i + 16]) end end
      if y == 4 then if x == i + 8 then stop_note(notes[i + 19]) end end
      if y == 3 then if x == i + 8 then stop_note(notes[i + 22]) end end
      if y == 2 then if x == i + 8 then stop_note(notes[i + 25]) end end
      if y == 1 then if x == i + 8 then stop_note(notes[i + 28]) end end
    end
  end
end

function grid_redraw()
  if grid_connected then -- only redraw if there's a grid connected
    g:all(0) -- turn all the LEDs off

    -- light up drum pads
    g:led(3,3,3) -- 
    g:led(4,3,3) -- 
    g:led(5,3,3) -- 
    g:led(6,3,3) -- 
    g:led(3,4,3) -- 
    g:led(4,4,3) -- 
    g:led(5,4,3) -- 
    g:led(6,4,3) -- 
    g:led(3,5,3) -- 
    g:led(4,5,3) -- 
    g:led(5,5,3) -- 
    g:led(6,5,3) -- 
    g:led(3,6,3) -- 
    g:led(4,6,3) -- 
    g:led(5,6,3) -- 
    g:led(6,6,3) -- 

    -- light up live pads
    for x = 9,16 do
      for y = 1,8 do
        g:led(x,y,3)
        -- manually lighting roots
        g:led(9,1,6)
        g:led(16,1,6)
        g:led(12,2,6)
        g:led(15,3,6)
        g:led(11,4,6)
        g:led(14,5,6)
        g:led(10,6,6)
        g:led(13,7,6)
        g:led(9,8,6)
        g:led(16,8,6)
      end
    end
  end
  g:refresh()
end

function redraw()
  screen.clear()
  screen.color(180, 255, 252, 0.8)
  screen.move(20, 20)
  screen.text('Ableton midi grid')
  screen.color(236, 195, 216, 0.8)
  screen.move(20, 40)
  screen.text('Note played: ' .. note_display_name)

  screen.refresh()
end

function grid_redraw_clock() -- our grid redraw clock
  while true do -- while it's running...
    clock.sleep(1/30) -- refresh at 30fps.
    if grid_dirty then -- if a redraw is needed...
      grid_redraw() -- redraw...
      grid_dirty = false -- redraw...
    end
    if screen_dirty then -- if a redraw is needed...
      redraw() -- redraw...
      screen_dirty = false -- then redraw is no longer needed.
    end
  end
end


function grid.add(new_grid) -- must be grid.add, not g.add (this is a function of the grid class)
  print(new_grid.name.." says 'hello!'")
   -- each grid added can be queried for device information:
  print("new grid found at port: "..new_grid.port)
  g = grid.connect(new_grid.port) -- connect script to the new grid
  grid_connected = true -- a grid has been connected!
  grid_dirty = true -- enable flag to redraw grid, because data has changed
end

function grid.remove(g) -- must be grid.remove, not g.remove (this is a function of the grid class)
  print(g.name.." says 'goodbye!'")
  grid_connected = false -- a grid has been connected!
end


cleanup = function ()
  g:all(0)
  g:refresh()
end
