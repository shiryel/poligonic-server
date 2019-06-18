# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Poligonic.Repo.insert!(%Poligonic.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Poligonic.Repo
alias Poligonic.Component.{PlayerMapsMasterPoligons, MasterPoligon, PlayerMap, Coordinate, PoligonStruct, Poligon, Hitbox, Cannon, Bullet}
alias Poligonic.Authentication.{User}

inserted_at = NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)

Repo.insert! %User{
  username: "vinicius",
  email: "vinicius_molina10@hotmail.com",
  password_hash: "test",
  inserted_at: inserted_at,
  player_maps: [
    %PlayerMap{
      name: "mapa 1",
      player_maps_master_poligons: [
        %PlayerMapsMasterPoligons{
          x: 1.0,
          y: 2.0,
          z: 0,
          master_poligon: %MasterPoligon{
            name: "poligono 1",
            role: "wall",
            poligons: [
              %Poligon{
                z: 0,
                role: "wall",
                poligon_structs: [
                  %PoligonStruct{
                    color: "blue",
                    z: 0,
                    routes: [
                      %Coordinate{x: 1.0, y: 2.0},
                      %Coordinate{x: 2.0, y: 2.0},
                      %Coordinate{x: 10.0, y: 20.0}
                    ]
                  }
                ],
                hitboxs: [
                  %Hitbox{
                    life: 20,
                    godmode: false,
                    routes: [
                      %Coordinate{x: 1.0, y: 2.0},
                      %Coordinate{x: 2.0, y: 2.0},
                      %Coordinate{x: 10.0, y: 20.0}
                    ]
                  }
                ]
              },
              %Poligon{
                z: 1,
                role: "cannon",
                poligon_structs: [
                  %PoligonStruct{
                    color: "red",
                    z: 1,
                    routes: [
                      %Coordinate{x: 2.0, y: 4.0},
                      %Coordinate{x: 8.0, y: 10.0},
                      %Coordinate{x: 20.0, y: 15.0}
                    ]
                  }
                ],
                hitboxs: [
                  %Hitbox{
                    life: 1,
                    godmode: true,
                    routes: [
                      %Coordinate{x: 2.0, y: 4.0},
                      %Coordinate{x: 8.0, y: 10.0},
                      %Coordinate{x: 20.0, y: 15.0}
                    ]
                  }
                ],
                cannon: %Cannon{
                  fire_rate: 10,
                  out_x: 4.0,
                  out_y: 5.0,
                  out_invert: false,
                  bullets: [
                    %Bullet{
                      damage: 10,
                      trigger_x: 5.0,
                      trigger_y: 6.0,
                      poligon: %Poligon{
                        z: 2,
                        role: "bullet",
                        poligon_structs: [
                          %PoligonStruct{
                            color: "dark",
                            z: 2,
                            routes: [
                              %Coordinate{x: 2.0, y: 4.0},
                              %Coordinate{x: 8.0, y: 10.0},
                              %Coordinate{x: 20.0, y: 15.0}
                            ]
                          }
                        ]
                      }
                    }
                  ]
                }
              }
            ]
          }
        }
      ]
    }
  ]
}

IO.puts ""
IO.puts "Success! Repository sucessifuly populatedy"
