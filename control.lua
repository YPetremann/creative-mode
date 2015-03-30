require("defines")
local serpent = require("serpent")

function string.starts(String,Start)
  return string.sub(String,1,string.len(Start))==Start
end
function Set(l)
  local s={}
  for i,k in ipairs(l) do
    s[k]=i
  end
  return s
end

function getTileBBox(p)
  return{
    {math.floor(p.x),math.floor(p.y)},
    {math.ceil(p.x),math.ceil(p.y)}
  }
end
function getBBox(p,r)
  return{{p.x-r,p.y-r},{p.x+r,p.y+r}}
end
function hasinventory(e,i)
  if i == nil then
    for _,k in pairs(defines.inventory) do
      if pcall(function()e.getinventory(k)end) then
        return e.getinventory(k)
      end
    end
  elseif pcall(function()e.getinventory(i)end) then
    return e.getinventory(i)
  end
  return false
end
function hasfluidbox(e)
  if pcall(function() return e.fluidbox end) then
    return #e.fluidbox
  end
  return false
end


ground_entity = Set{
  "item-entity",
  "simple-entity",
  "transport-belt",
  "transport-belt-to-ground",
  "decorative",
  "smoke",
  "construction-robot",
  "logistic-robot",
  "player"
}
chest_output = {
  [0]={x1=-0.25,y1=-0.75,x2= 0.25,y2=-0.75},
  [2]={x1= 0.75,y1=-0.25,x2= 0.75,y2= 0.25},
  [4]={x1=-0.25,y1= 0.75,x2= 0.25,y2= 0.75},
  [6]={x1=-0.75,y1=-0.25,x2=-0.75,y2= 0.25}
}
chest_input = {
  [0]={x1=-0.25,y1=-0.51,x2= 0.25,y2=-0.51},
  [2]={x1= 0.51,y1=-0.25,x2= 0.51,y2= 0.25},
  [4]={x1=-0.25,y1= 0.51,x2= 0.25,y2= 0.51},
  [6]={x1=-0.51,y1=-0.25,x2=-0.51,y2= 0.25}
}

function oninit()
  if not glob.item_source then glob.item_source = {} end
  if not glob.item_sink then glob.item_sink = {} end
  if not glob.energy_source then glob.energy_source = {} end
  if not glob.energy_sink then glob.energy_sink = {} end
end
function onbuiltentity(event) 
  if event.createdentity.name == "item-source" then
    table.insert(glob.item_source, event.createdentity)
  elseif event.createdentity.name == "item-sink" then
    table.insert(glob.item_sink, event.createdentity)
  elseif event.createdentity.name == "energy-source" then
    table.insert(glob.energy_source, event.createdentity)
  elseif event.createdentity.name == "energy-sink" then
    table.insert(glob.energy_sink, event.createdentity)
  end
end
function ontick(event)
  for index, item_sink in ipairs(glob.item_sink) do
    if item_sink.valid then
      item_sink.energy = 10
      local pos = item_sink.position
      local dir = chest_input[item_sink.direction]
      input{x = pos.x + dir.x1, y = pos.y + dir.y1}
      inputfluid{x = pos.x + dir.x1, y = pos.y + dir.y1}
      input{x = pos.x + dir.x2, y = pos.y + dir.y2}
      inputfluid{x = pos.x + dir.x2, y = pos.y + dir.y2}
    else
      table.remove(glob.item_sink, index)
    end
  end
  for index, item_source in ipairs(glob.item_source) do
    if item_source.valid then
      item_source.energy = 10
      local slot1 = {name = item_source.getfilter(1), count = 1}
      local slot2 = {name = item_source.getfilter(2), count = 1}
      local pos = item_source.position
      local dir = chest_output[item_source.direction]
      if slot1.name ~= nil then
        if string.starts(slot1.name,"creative-fluid-") then
          outputfluid({type=string.sub(slot1.name,16),amount=10}, {x = pos.x + dir.x1, y = pos.y + dir.y1})
        else
          output(slot1, {x = pos.x + dir.x1, y = pos.y + dir.y1})
        end
      end
      if slot2.name ~= nil then
        if string.starts(slot2.name,"creative-fluid-") then
          outputfluid({type=string.sub(slot2.name,16),amount=10}, {x = pos.x + dir.x1, y = pos.y + dir.y1})
        else
          output(slot2, {x = pos.x + dir.x2, y = pos.y + dir.y2})
        end
      end
    else
      table.remove(glob.item_source, index)
    end
  end
  if game.tick % 60 == 0 then
    for index, energy_sink in ipairs(glob.energy_sink) do
      if energy_sink.valid then
        energy_sink.energy = 0
      else
        table.remove(glob.energy_sink, index)
      end
    end
    for index, energy_source in ipairs(glob.energy_source) do
      if energy_source.valid then
        energy_source.energy = 1000000000000000
      else
        table.remove(glob.energy_source, index)
      end
    end
  end
end
function output(item,position)
  local storage_entity = nil
  local on_ground = true
  for _, entity in ipairs(game.findentities(getTileBBox(position))) do
    if not ground_entity[entity.type] then
      on_ground = false
      if entity.caninsert(item) then
        storage_entity = entity
        break
      end
    end
  end
  if storage_entity then
    local buf = storage_entity.getitemcount(item.name)
    storage_entity.insert(item)
    local buf2 = storage_entity.getitemcount(item.name)
    item.count = buf2-buf
    return item
  end
  if on_ground and not next(game.findentitiesfiltered{area=getBBox(position, 0.14), name="item-on-ground"}) then
    game.createentity{name = "item-on-ground", position = position, stack = item}
  end
end
function input(position)
  local storage_entity = nil
  local on_ground = true
  for _, entity in ipairs(game.findentities(getTileBBox(position))) do
    if not ground_entity[entity.type] and entity.getitemcount() > 0 then
      storage_entity = entity
      break
    end
  end
  if storage_entity then
    for _, i in pairs(defines.inventory) do
      local inventory = hasinventory(storage_entity,i)
      if inventory and not inventory.isempty() then
        for i = 1,#inventory do
          if inventory[i] ~= nil then
            item = {name=inventory[i].name,count=1}
            inventory.remove(item)
            return item
          end
        end
      end
    end
  end
  items = game.findentitiesfiltered{area=getBBox(position,0.14),name="item-on-ground"}
  for _,item in ipairs(items) do
    item.destroy()
  end
end
function outputfluid(item,position)
  local storage_entity = nil
  for _, entity in ipairs(game.findentities(getTileBBox(position))) do
    if not ground_entity[entity.type] and hasfluidbox(entity) then
      storage_entity = entity
      break
    end
  end
  if storage_entity then
    local fluidbox = storage_entity.fluidbox
    if fluidbox then
      for i = 1,#fluidbox do
        fluid = fluidbox[i]
        if fluid == nil then
          fluidbox[i] = {type = item.type, amount = item.amount}
        elseif fluid.type == item.type then
          fluid.amount = fluid.amount + item.amount
          fluidbox[i] = fluid
        end
      end
    end
  end
end
function inputfluid(position)
  local storage_entity = nil
  local on_ground = true
  for _, entity in ipairs(game.findentities(getTileBBox(position))) do
    if not ground_entity[entity.type] and hasfluidbox(entity) then
      storage_entity = entity
      break
    end
  end
  if storage_entity then
    local fluidbox = storage_entity.fluidbox
    if fluidbox then
      for i = 1,#fluidbox do
        amount = 1
        fluid = fluidbox[i]
        if fluid then
          if amount >= fluid.amount then
            amount = fluid.amount
            fluidbox[i] = nil
          else
            fluid.amount = fluid.amount - amount
            fluidbox[i] = fluid
          end
          return {type = fluid, amount = amount, temperature = fluid.temperature}
        end
      end
    end
  end
end

onload = oninit
onrobotbuiltentity = onbuiltentity

game.oninit(oninit)
game.onload(onload)
game.onevent(defines.events,onevent)
for k,v in pairs(defines.events) do 
  if type(_G[k]) == "function" then
    game.onevent(v,_G[k])
  end
end
