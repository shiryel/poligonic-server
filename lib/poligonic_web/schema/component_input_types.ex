defmodule PoligonicWeb.Schema.ComponentInputTypes do
  use PoligonicWeb.Resolvers.Util

  input_object :input_player_map do
    non_null :name, :string
    non_null :user, :input_user
    non_null :player_maps_master_poligons, list_of(:input_player_maps_master_poligons)
  end

  input_object :input_player_maps_master_poligons do
    non_null :x, :float
    non_null :y, :float
    non_null :z, :integer
    non_null :master_poligon, :input_master_poligon
    non_null :player_map, :input_player_map
  end

  input_object :input_master_poligon do
    non_null :name, :string
    non_null :role, :string
    non_null :poligons, list_of(:input_poligon)
    non_null :player_maps_master_poligons, list_of(:input_player_maps_master_poligons)
  end

  input_object :input_poligon do
    non_null :z, :integer
    non_null :role, :string
    non_null :poligon_structs, list_of(:input_poligon_struct)
    non_null :bullet, :input_bullet
    non_null :cannon, :input_cannon
  end

  input_object :input_poligon_struct do
    non_null :routes, list_of(:input_coordinate)
    non_null :color, :string
    non_null :z, :integer
  end

  input_object :input_coordinate do
    non_null :x, :float
    non_null :y, :float
  end

  input_object :input_hitbox do
    non_null :routes, list_of(:input_coordinate)
    non_null :life, :integer
    non_null :godmode, :boolean
  end

  input_object :input_cannon do
    non_null :fire_rate, :integer
    non_null :out_x, :float
    non_null :out_y, :float
    non_null :out_invert, :boolean
    non_null :bullets, list_of(:input_bullet)
  end

  input_object :input_bullet do
    non_null :damage, :integer
    non_null :trigger_x, :float
    non_null :trigger_y, :float
    non_null :cannons, list_of(:input_cannon)
  end
end
