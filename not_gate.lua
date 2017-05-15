not_gate = class()

function not_gate:init(obj)
    self.width,self.height = 1,1
    self.name,self.type = "NOT GATE","gate"
    self.can_add_to = {"editor"}
    self.gate_id = 1
    if obj then
        local e = obj.editor
        local s = e.size
        self.obj = obj
        self.update_button_pos(self) -- Add button.
        self.wire = wire_line(vec2(-1,0),vec2(1,0),e,#e.wire.lines+1) -- Wire.
    end
end

function not_gate:draw(s,x,y,info)
    local x,y = (x or 0)*s,(y or 0)*s 

    if self.wire then -- Wire.
        translate(x,y) self.wire:draw(s) translate(-x,-y) 
    end

    gdc()
    rect(x,y,self.width*s,self.height*s) COLOR2.a = 255 -- Background
    fill(COLOR2) fontSize(s) text("N",x,y) -- "N"

    if self.button then flat_ui:button_draw(self.button) end
end

function not_gate:update()
    if self.output and self.input then
        self.output.input.value = 1-self.input.output.value
    end
end

function not_gate:update_button_pos(s)
    local s = self or s
    if not s.obj.editor then return end
    if not s.button then s.button = flat_ui:add_button(0,0,0,0,color(0,0)) end
    local ed = s.obj.editor
    local cpos = vec2(ed.camera.x,ed.camera.y)
    local pos = vec2(s.obj.x,s.obj.y)*ed.size-cpos
    
    s.button.x,s.button.y = pos:unpack()
    s.button.width,s.button.height = s.width*ed.size,s.height*ed.size
end

function not_gate:touched(t)
    
end
