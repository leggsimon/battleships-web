module Battleships
  class Ship
    SHIPS = {'destroyer' => Ship.destroyer,
             'battleship' => Ship.battleship,
             'aircraft_carrier' => Ship.aircraft_carrier,
             'submarine' => Ship.submarine,
             'cruiser' => Ship.cruiser}
  end
end