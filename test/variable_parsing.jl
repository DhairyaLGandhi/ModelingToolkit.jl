using ModelingToolkit
using Test

@parameters t()
@variables x(t) y(t) z(t)
x1 = Variable(:x)(t)
y1 = Variable(:y)(t)
z1 = Variable(:z)(t)
@test isequal(x1, x)
@test isequal(y1, y)
@test isequal(z1, z)

@parameters begin
    t()
    s()
    σ
end
t1 = Variable(:t; known = true)()
s1 = Variable(:s; known = true)()
σ1 = Variable(:σ; known = true)
@test isequal(t1, t)
@test isequal(s1, s)
@test isequal(σ1, σ)

@derivatives D'~t
D1 = Differential(t)
@test D1 == D

@test isequal(x ≤ y + 1, (x < y + 1) | (x == y + 1))
