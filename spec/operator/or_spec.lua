local util = require("spec.util")

describe("or", function()
   it("map or record matching map", util.check [[
      local type Ty = record
         name: string
         foo: number
      end
      local t: Ty = { name = "bla" }
      local m1: {string:Ty} = {}
      local m2: {string:Ty} = m1 or { foo = t }
   ]])

   it("record or record: need to be same type", util.check_type_error([[
      local record R1
         x: string
         y: string
      end
      local record R2
         x: string
      end
      local r1: R1
      local r2: R2
      local r3 = r2 or r1
   ]], {
      { msg = "cannot use operator 'or' for types R2 and R1" }
   }))

   it("string or enum matches enum", util.check [[
      local type Dir = enum
         "left"
         "right"
      end

      local v: Dir = "left"
      local x: Dir = v or "right"
      local y: Dir = "right" or v
   ]])

   it("invalid string or enum matches string", util.check_type_error([[
      local type Dir = enum
         "left"
         "right"
      end

      local v: Dir = "left"
      local x = v or "don't know"
      v = x
   ]], {
      { y = 8, msg = "in assignment: string is not a Dir" }
   }))
end)
