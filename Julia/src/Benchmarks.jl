module Benchmarks

export pv_claims, pv_premiums, pv_commissions, pv_expenses, pv_net_cf, result_pv, result_cf

using DataFrames, CSV, Memoize
using Dates

data_file(file) = joinpath(@__DIR__, "data", joinpath(split(file, '/')...))
function read_csv(file)
  !isabspath(file) && (file = data_file(file))
  CSV.read(file, DataFrame)
end

const final_timestep = Ref{Int}(240)
duration(t::Int) = t ÷ 12

include("mortality.jl")
include("basic_term.jl")

using Accessors: @set
using CSV
using DataFrames
using PythonCall
using Random

include("policy.jl")
include("model.jl")
include("simulation.jl")
include("cashflow.jl")
include("lifelib.jl")

export
  Sex, MALE, FEMALE,
  Policy, policies_from_lifelib,
  PolicySet, policy_count,
  Model, LifelibSavings, investment_rate, brownian_motion, LifelibBasiclife,
  Simulation, SimulationResult, next!, simulate!, simulation_range,
  CashFlow,
  read_savings_model, ntimesteps, python_directory, use_policies!
end
