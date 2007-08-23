ENV['PROJ_LIB'] = File.dirname(__FILE__) + '/../data'
require 'projrb'

# Ruby bindings for the Proj4 cartographic projection library.
module Proj4

    # The UV class holds one coordinate pair. Can be either lon/lat or x/y.
    class UV

        # Compare to UV instances, they are equal if both coordinates are equal, respectively.
        def ==(uv)
            self.u == uv.u && self.v == uv.v
        end

        # Create string in format 'x,y'.
        def to_s
            "#{u},#{v}"
        end

    end

    # The Projection class represents a geographical projection.
    class Projection

        # Convenience function for calculating a forward projection with degrees instead of radians.
        def forwardDeg(uv)
            forward(Proj4::UV.new( uv.u * Proj4::DEG_TO_RAD, uv.v * Proj4::DEG_TO_RAD))
        end

        # Convenience function for calculating an inverse projection with the result in degrees instead of radians.
        def inverseDeg(uv)
            uvd = inverse(uv)
            Proj4::UV.new( uvd.u * Proj4::RAD_TO_DEG, uvd.v * Proj4::RAD_TO_DEG)
        end

    end

    class Unit

        # Get the unit with given id.
        def self.get(id)
            self.listUnits.select{ |u| u.id == id }.first
        end

        # Compares units by comparing ids.
        def <=>(other)
            self.id <=> other.id
        end

        # Stringify unit.
        def to_s
            id
        end

        # Returns unit definition as string in format '#<Proj4::Unit id="...", to_meter="...", name="...">'.
        def inspect
            "#<Proj4::Unit id=\"#{id}\", to_meter=\"#{to_meter}\", name=\"#{name}\">"
        end

    end

end
