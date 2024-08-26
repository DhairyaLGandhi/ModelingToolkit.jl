module MTKChainRulesCoreExt

import ModelingToolkit as MTK
import ChainRulesCore
import ChainRulesCore: NoTangent

function ChainRulesCore.rrule(::Type{MTK.MTKParameters}, tunables, args...)
    function mtp_pullback(dt)
        t = hasproperty(dt, :tunables) ? dt.tunables : dt[1]
        (NoTangent(), t[1:length(tunables)], ntuple(_ -> NoTangent(), length(args))...)
    end
    function mtp_pullback(dt::AbstractArray)
        (NoTangent(), dt[1:length(tunables)], ntuple(_ -> NoTangent(), length(args))...)
    end
    MTK.MTKParameters(tunables, args...), mtp_pullback
end

end
