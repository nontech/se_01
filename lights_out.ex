defmodule LightsOut do
  @moduledoc
  """
  This module is about building the Lights Out game.
  See - https://daattali.com/shiny/lightsout/
  """

  def within_matrix?([row, col] = _aGrid) do
    cond do
      row < 0 or row > 2 ->
        false

      col > 2 or col < 0 ->
        false

      true ->
        true
    end
  end

  def adjacent_grids_list([row, col] = _aGrid) do
    # condition: 1 step forward and backward and either direction. So, max 4 moves and thus max 4 possible adjacent grids
    [[row + 1, col], [row - 1, col], [row, col + 1], [row, col - 1]]
    |> Enum.filter(fn x -> within_matrix?(x) end)
  end

  def update_matrix(matrix, [row, col] = _aGrid) do
    matrix
    |> Enum.map(fn [r, c, _initial_state] = matrix_grid ->
      if row == r and col == c do
        xxtoggle_state(matrix_grid)
      else
        matrix_grid
      end
    end)
  end

  def updated_matrix(grid_list) do
    grid_list
    |> Enum.reduce(xxinitial_matrix(), fn aGrid, acc ->
      update_matrix(acc, aGrid)
    end)
  end

  def start_game() do
    grid_clicked = [0, 0]

    # find adjacent grids
    adjacent_grids = adjacent_grids_list(grid_clicked)

    # get all grids for update
    update_grids_list = adjacent_grids ++ [grid_clicked]

    # update all grids status
    updated_matrix(update_grids_list)
  end

  def xxtoggle_state([row, col, state] = _aGrid_with_state) do
    if state == "active", do: [row, col, "inactive"], else: [row, col, "active"]
  end

  def xxinitial_matrix() do
    [
      [0, 0, "active"],
      [0, 1, "active"],
      [0, 2, "active"],
      [1, 0, "active"],
      [1, 1, "active"],
      [1, 2, "active"],
      [2, 0, "active"],
      [2, 1, "active"],
      [2, 2, "active"]
    ]
  end
end
