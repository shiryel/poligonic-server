defmodule PoligonicWeb.Schema.ComponentTypes do
  use PoligonicWeb.Resolvers.Util

  @desc "Mapa de um unico jogador"
  object :player_map do
    field :name, :string
    field :user, :user
    field :player_maps_master_poligons, list_of(:player_maps_master_poligons) do
      resolve Util.list_by_assoc(:player_maps_master_poligons)
    end
  end

  object :result_player_map do
    field :player_map, :player_map
    field :errors, list_of(:error)
  end

  @desc "Localidades dos poligonos mestres nos diversos mapas de um jogador"
  object :player_maps_master_poligons do
    field :x, :float
    field :y, :float
    field :z, :integer
    field :master_poligon, :master_poligon do
      resolve Util.get_by_assoc(:master_poligon)
    end
    field :player_map, :player_map do
      resolve Util.get_by_assoc(:player_map)
    end
  end

  @desc "Poligono mestre, controla como funciona o relacionamento de diversos poligonos e constroi a infraestrutura basica do jogo"
  object :master_poligon do
    @desc "Nome do poligono mestre"
    field :name, :string

    @desc """
    Como o poligono mestre se comporta dentro do jogo Ex:
    Tower -> Se comporta como uma estrutura no mapa, contem varios hitboxs, cannons e bullets
    Ship -> Se comporta como um caça, contem varios hitboxs, cannons e bullets
    Background -> Poligono de enfeite, nao contem tabelas associadas alem do poligon_structs
    Wall -> Se comporta como uma parede, contem apenas os hitboxs, pode ser imortal
    """
    field :role, :string

    @desc "Poligonos que compoem o master poligon"
    field :poligons, list_of(:poligon) do
      resolve Util.list_by_assoc(:poligons)
    end

    @desc "Retorna os mapas do player com o posicionamento dos poligonos mestres"
    field :player_maps_master_poligons, list_of(:player_maps_master_poligons) do
      resolve Util.list_by_assoc(:player_maps_master_poligons)
    end
  end

  object :result_master_poligon do
    field :master_poligon, :master_poligon
    field :erorrs, list_of(:error)
  end

  @desc "Objeto principal para construir o poligono, carrega sua estrutura com uma lista de pontos e resolve seu tipo pelo enum :role"
  object :poligon do
    @desc "Onde o poligono se localiza no angulo 'z'"
    field :z, :integer

    @desc "Espefica como este poligono se comporta no jogo"
    field :role, :string

    @desc "Sao as estruturas basicas dos poligonos, as suas rotas de pontos para sua criaçao (OBRIGATORIO)"
    field :poligon_structs, list_of(:poligon_struct) do
      resolve Util.list_by_assoc(:poligon_structs)
    end

    @desc "Sao os hitboxs dos poligonos"
    field :hitboxs, list_of(:hitbox) do
      resolve Util.list_by_assoc(:hitboxs)
    end

    @desc "Sao as muniçoes para os canhoes"
    field :bullet, :bullet do
      resolve Util.get_by_assoc(:bullet)
    end

    @desc "Sao os canhoes encontrados nos varios poligonos do jogo"
    field :cannon, :cannon do
      resolve Util.get_by_assoc(:cannon)
    end
  end

  object :result_poligon do
    field :poligon, :poligon
    field :errors, list_of(:error)
  end

  @desc "Estrutura basica de um poligono, possui varias rotas para formar uma parte de poligono"
  object :poligon_struct do
    field :routes, list_of(:coordinate)
    field :color, :string
    field :z, :integer
  end

  @desc "Coordenadas da estrutura de um objeto"
  object :coordinate do
    field :x, :float
    field :y, :float
  end

  @desc "Hitboxs de um poligono"
  object :hitbox do
    field :routes, list_of(:coordinate)
    field :life, :integer
    field :godmode, :boolean
  end

  @desc "Caso um poligono se comporte como um canhao ele necessita referenciar este"
  object :cannon do
    field :fire_rate, :integer
    field :out_x, :float
    field :out_y, :float
    field :out_invert, :boolean
    field :bullets, list_of(:bullet) do
      resolve Util.list_by_assoc(:bullets)
    end
  end

  @desc "Balas para serem usados no [:cannon]"
  object :bullet do
    field :damage, :integer
    field :trigger_x, :float
    field :trigger_y, :float
    field :cannons, list_of(:cannon) do
      resolve Util.list_by_assoc(:cannons)
    end
  end
end

