import DynamicQuantities
const DQ = DynamicQuantities

struct ValidationError <: Exception
    message::String
end

check_units(::Nothing, _...) = true

__get_literal_unit(x) = getmetadata(x, VariableUnit, nothing)
function __get_unit_type(vs′...)
    vs = Iterators.flatten(vs′)
    for v in vs
        u = __get_literal_unit(v)
        if u isa DQ.AbstractQuantity
            return Val(:Unitful)
        else
            return Val(:DynamicQuantities)
        end
    end
    return nothing
end

function check_units(::Val{:DynamicQuantities}, eqs...)
    validate(eqs...) ||
        throw(ValidationError("Some equations had invalid units. See warnings for details."))
end

function screen_units(result)
    if result isa DQ.AbstractQuantity
        d = DQ.dimension(result)
        if d isa DQ.Dimensions
            return result
        elseif d isa DQ.SymbolicDimensions
            throw(ValidationError("$result uses SymbolicDimensions, please use `u\"m\"` to instantiate SI unit only."))
        else
            throw(ValidationError("$result doesn't use SI unit, please use `u\"m\"` to instantiate SI unit only."))
        end
    end
end


