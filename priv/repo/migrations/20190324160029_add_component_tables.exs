defmodule Poligonic.Repo.Migrations.AddComponentTables do
  use Ecto.Migration

  @doc false
  def change do
    # Usuario
    create table(:users) do
      add :username, :string
      add :email, :string
      add :password_hash, :string

      timestamps()
    end

    # Mapas dos jogadores
    create table(:player_maps) do
      add :name, :string, null: false
      add :user_id, references(:users, on_delete: :delete_all)
    end

    # Em [:users] nao pode haver multiples usernames ou emails
    create unique_index(:users, [:username])
    create unique_index(:users, [:email])

    # Clusteriza poligonos
    # Poligono raiz
    # > Um jogador pode criar um poligono raiz e vender ele na loja para
    #   outros players utilizarem em seus mapas, porem ele deve manter o
    #   autor original
    # > :role define como o poligono raiz deve se comportar no jogo
    create table(:master_poligons) do
      add :name, :string, null: true
      add :role, :string, null: false
      add :user_id, references(:users, on_delete: :delete_all)
    end

    create index(:master_poligons, [:role])

    # Posicionamento do [:master_poligons] em relaçao ao [:player_maps]
    # Posiciona os poligos em reçao ao eixo 0,0 da tela
    create table(:player_maps_master_poligons) do
      add :x, :float, null: false
      add :y, :float, null: false
      add :z, :integer, null: false
      add :master_poligon_id, references(:master_poligons, on_delete: :delete_all)
      add :player_map_id, references(:player_maps, on_delete: :delete_all)
    end

    # Poligono basico
    # Se constitui de varios [:poligon_structs]
    # Pode se comportar como [:hitboxs, :cannons, :bullets]
    # É utilizado pelo [:master_poligons] para gerar o poligono principal
    # > :role define como o poligono deve se comportar no poligono principal
    create table(:poligons) do
      add :z, :integer, null: false
      add :role, :string, null: false

      add :master_poligon_id, references(:master_poligons, on_delete: :delete_all)

      timestamps()
    end

    # COMPOSE
    # Permique que um poligono tenha uma hitbox
    create table(:hitboxs) do
      add :routes, :jsonb, null: false # Para nao ter que calcular a rota basica de colisao toda vez
      add :life, :integer, null: false # Inteiro para diminuir carga de contas
      add :godmode, :boolean, null: false # Imortabilidade, independe da [:life]
      add :poligon_id, references(:poligons, on_delete: :delete_all)
    end

    # BEHAVIOR
    # Permite que um poligono assuma o comportamento de um canhao
    create table(:cannons) do
      add :fire_rate, :integer, null: false # Inteiro para diminuir carga de contas
      # outs definem de onde a bala deve sair, e em que direçao
      add :out_x, :float, null: false
      add :out_y, :float, null: false
      # se out_invert = false ele saira positivamente (left)(up)
      # se out_invert = true ele saira negarivamente (right)(down)
      add :out_invert, :boolean, null: false
      add :poligon_id, references(:poligons, on_delete: :delete_all)
    end

    # BEHAVIOR
    # Permite que um poligono assuma o comportamento de uma bala
    create table(:bullets) do
      add :damage, :integer, null: false
      # Triggeres em relaçao a posiçao inicial [x:0, y:0 do poligono]
      add :trigger_x, :float, null: false
      add :trigger_y, :float, null: false
      add :poligon_id, references(:poligons, on_delete: :delete_all)
    end

    # Um canhao pode ter muitas balas, e uma bala pode estar em muitos canhoes
    create table(:cannons_bullets) do
      add :cannon_id, references(:cannons, on_delete: :delete_all)
      add :bullet_id, references(:bullets, on_delete: :delete_all)
    end

    # Particula do poligono
    # É o poligono "atomo" basico da infraestrutura de poligonos
    create table(:poligon_structs) do
      add :routes, :jsonb, null: false
      add :z, :integer, null: false
      add :color, :string, null: false
      add :poligon_id, references(:poligons, on_delete: :delete_all)
    end

  end
end
