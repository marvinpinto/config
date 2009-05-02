-- Gadgets population.

-- Grab environment
local awful = require('awful')
local beautiful = require('beautiful')

if conf == nil then
   -- should trace something here...
   -- perhaps should bind minimal default keys (restart).
end


-- Create a textbox widget for the date
conf.widgets.datebox = widget({ type = "textbox", align = "right" })
conf.widgets.datebox.text = "<b><small> " .. AWESOME_RELEASE .. " </small></b>"

-- Create CPU, CPUfreq monitor
conf.gadgets.cpu_icon = flaw.gadget.new(
   'flaw.cpu.imagebox', 'cpu', {},
   {
      image = image(beautiful.icon_cpu)
   }
)

conf.gadgets.cpugraph = flaw.gadget.new(
   'flaw.cpu.graph', 'cpu', {}, {
      width = '35',
      height = '0.8',
      grow = 'right',
      bg = beautiful.bg_normal,
      fg = beautiful.fg_normal,
      max_value = '100' }
)

-- Create network monitor
conf.gadgets.netgraph = flaw.gadget.new(
  'flaw.network.graph', 'wlan0', {}, {
     width = '35',
     height = '0.8',
     grow = 'right',
     bg = beautiful.bg_normal,
     fg = beautiful.fg_normal,
     max_value = '100000' }
)

conf.gadgets.netbox = flaw.gadget.new(
   'flaw.network.textbox', 'wlan0', { })


-- conf.widgets.memory_box = flaw.gadget.new('flaw.memory.textbox', '').widget

-- Create battery monitor
conf.gadgets.battery_icon = flaw.gadget.new(
   'flaw.battery.imagebox', 'BAT0',
   {
      my_icons = {
         image(beautiful.icon_battery_low),
         image(beautiful.icon_battery_mid),
         image(beautiful.icon_battery_full)
      },
      my_load_icon = image(beautiful.icon_battery_plugged),
      my_update = function(self)
                     if self.provider.data.st_symbol == flaw.battery.STATUS_CHARGING then
                        self.widget.image = self.my_load_icon
                     else
                        self.widget.image = self.my_icons[math.floor(self.provider.data.load / 30) + 1]
                     end
                  end
   },
   {
      image = image(beautiful.icon_battery_full)
   }
)
conf.gadgets.battery_icon:add_event(
   flaw.event.EdgeTrigger:new{ condition = function(d) return d.load < 60 end },
   function (g) g:my_update() end
)
conf.gadgets.battery_icon:add_event(
   flaw.event.EdgeTrigger:new{ condition = function(d) return d.load < 30 end },
   function (g) g:my_update() end
)
conf.gadgets.battery_icon:add_event(
   flaw.event.EdgeTrigger:new{
      condition = function(d) return d.st_symbol == flaw.battery.STATUS_CHARGING end },
   function (g) g:my_update() end
)
conf.gadgets.battery_icon:add_event(
   flaw.event.LatchTrigger:new{condition = function(d) return d.load < 10 end },
   function(g) naughty.notify{
         title = "Battery Warning",
         text = "Battery low! " .. g.provider.data.load .. "% left!",
         timeout = 10,
         position = "top_right",
         fg = beautiful.fg_focus,
         bg = beautiful.bg_focus} end
)

conf.gadgets.battery_box = flaw.gadget.new(
   'flaw.battery.textbox', 'BAT0',
   { pattern = '<span color="#99aa99">$load</span>% $time' } )
conf.gadgets.battery_box:add_event(
   flaw.event.LatchTrigger:new{condition = function(d) return d.load < 60 end },
   function(g) g.pattern = '<span color="#ffffff">$load</span>%' end
)
conf.gadgets.battery_box:add_event(
   flaw.event.LatchTrigger:new{condition = function(d) return d.load < 30 end },
   function(g) g.pattern = '<span color="#ff6565">$load</span>%' end
)

-- Create wifi monitor
-- local w_wifi_widget = wifi.widget_new('wlan0')

-- Create sound monitor
-- local w_sound_widget = sound.widget_new()


