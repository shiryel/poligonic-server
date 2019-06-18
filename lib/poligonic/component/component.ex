defmodule Poligonic.Component do
  @moduledoc """
  Poligon context
  """
  import Ecto.Query, warn: false
  alias Poligonic.Repo

  alias Poligonic.Component.{PlayerMapsMasterPoligons, MasterPoligon, PlayerMap, PoligonStruct, Poligon, Hitbox, Cannon, Bullet}

  ###############################################################
  ### PLAYER MAP ###
  ###############################################################

  @spec create_player_map(
          :invalid
          | %{optional(:__struct__) => none(), optional(atom() | binary()) => any()}
        ) :: any()
  def create_player_map(attrs) do
    %PlayerMap{}
    |> PlayerMap.changeset(attrs)
    |> Repo.insert
  end

  ###############################################################
  ### PLAYER MAPS MASTER POLIGONS ###
  ###############################################################

  @spec create_player_maps_master_poligons(
          :invalid
          | %{optional(:__struct__) => none(), optional(atom() | binary()) => any()}
        ) :: any()
  def create_player_maps_master_poligons(attrs) do
    %PlayerMapsMasterPoligons{}
    |> PlayerMapsMasterPoligons.changeset(attrs)
    |> Repo.insert
  end

  ###############################################################
  ### MASTER POLIGON ###
  ###############################################################
  @spec create_master_poligon(
          :invalid
          | %{optional(:__struct__) => none(), optional(atom() | binary()) => any()}
        ) :: any()
  def create_master_poligon(attrs) do
    %MasterPoligon{}
    |> MasterPoligon.changeset(attrs)
    |> Repo.insert
  end

  ###############################################################
  ### POLIGON ###
  ###############################################################

  @spec list_poligon(integer) :: list(any)
  @doc "Realiza a busta de todos os poligonos de um unico usuario"
  def list_poligon(user_id, preload \\ []) do
    Poligon
    |> where([p], p.user_id == ^user_id)
    |> preload(^preload)
    |> Repo.all()
  end

  @spec get_poligon(integer(), integer(), list()) :: any()
  @doc "Realiza a busca de um unico poligono por seu usuario"
  def get_poligon(user_id, id, preload \\ []) do
    Poligon
    |> where([p], p.user_id == ^user_id)
    |> preload(^preload)
    |> Repo.get(id)
  end

  @spec create_poligon(
          :invalid
          | %{optional(:__struct__) => none(), optional(atom() | binary()) => any()}
        ) :: any()
  @doc "Cria um novo poligono"
  def create_poligon(attrs) do
    %Poligon{}
    |> Poligon.changeset(attrs)
    |> Repo.insert()
  end

  @spec update_poligon(Poligonic.Component.Poligon.t(),
          :invalid
          | %{optional(:__struct__) => none(), optional(atom() | binary()) => any()}
          ) :: any()
  @doc "Atualiza um poligono"
  def update_poligon(%Poligon{} = poligon, attrs) do
    poligon
    |> Poligon.changeset(attrs)
    |> Repo.update()
  end

  @spec delete_poligon(Poligonic.Component.Poligon.t()) :: any()
  @doc "Deleta um poligono"
  def delete_poligon(%Poligon{} = poligon) do
    Repo.delete poligon
  end

  ###############################################################
  ### POLIGON STRUCT ###
  ###############################################################

  @spec create_poligon_struct(
          :invalid
          | %{optional(:__struct__) => none(), optional(atom() | binary()) => any()}
        ) :: any()
  @doc "Cria uma nova estrutura de poligono"
  def create_poligon_struct(attrs \\ %{}) do
    %PoligonStruct{}
    |> PoligonStruct.changeset(attrs)
    |> Repo.insert()
  end

  @spec update_poligon_struct(
          Poligonic.Component.PoligonStruct.t(),
          :invalid | %{optional(:__struct__) => none(), optional(atom() | binary()) => any()}
        ) :: any()
  @doc "Atualiza uma estrutura de poligono"
  def update_poligon_struct(%PoligonStruct{} = poligon_struct, attrs) do
    poligon_struct
    |> PoligonStruct.changeset(attrs)
    |> Repo.update()
  end

  @spec delete_poligon_struct(Poligonic.Component.PoligonStruct.t()) :: any()
  @doc "Deleta uma estrutura de poligono"
  def delete_poligon_struct(%PoligonStruct{} = poligon_struct) do
    Repo.delete(poligon_struct)
  end

  ###############################################################
  ### HITBOX ###
  ###############################################################

  @spec create_hitbox(
          :invalid
          | %{optional(:__struct__) => none(), optional(atom() | binary()) => any()}
        ) :: any()
  @doc """
  Cria um novo hitbox
  """
  def create_hitbox(attrs) do
    %Hitbox{}
    |> Hitbox.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Atualiza um hitbox
  """
  def update_hitbox(%Hitbox{} = hitbox, attrs) do
    hitbox
    |> Hitbox.changeset(attrs)
    |> Repo.update()
  end

  @spec delete_hitbox(Poligonic.Component.Hitbox.t()) :: any()
  @doc """
  Deleta um hitbox
  """
  def delete_hitbox(%Hitbox{} = hitbox) do
    Repo.delete(hitbox)
  end

  ###############################################################
  ### CANON ###
  ###############################################################

  def create_cannon(attrs) do
    %Cannon{}
    |> Cannon.changeset(attrs)
    |> Repo.insert()
  end

  def update_cannon(%Cannon{} = cannon, attrs) do
    cannon
    |> Cannon.changeset(attrs)
    |> Repo.update()
  end

  def delete_cannon(%Cannon{} = cannon) do
    Repo.delete(cannon)
  end

  ###############################################################
  ### BULLET ###
  ###############################################################

  def create_bullet(attrs) do
    %Bullet{}
    |> Bullet.changeset(attrs)
    |> Repo.insert()
  end

  def update_bullet(%Bullet{} = bullet, attrs) do
    bullet
    |> Bullet.changeset(attrs)
    |> Repo.update()
  end

  def delete_bullet(%Bullet{} = bullet) do
    Repo.delete(bullet)
  end

end
