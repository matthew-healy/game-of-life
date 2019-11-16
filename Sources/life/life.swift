public struct Game {
    private var liveCells: Set<Coordinate> = []

    public init() {}

    public mutating func setLive(at coordinate: Coordinate) {
        liveCells.insert(coordinate)
    }

    public mutating func nextGeneration() {
        forAllRelevantCells { coordinate in
            switch countLiveNeighbours(of: coordinate) {
            case (..<2): liveCells.remove(coordinate)
            case 3: liveCells.insert(coordinate)
            case (4...): liveCells.remove(coordinate)
            default: return
            }
        }
    }

    /// We define a "relevant" cell to be any cell
    /// which is at least as close to (0, 0) as the
    /// furthest-away live cell
    private func forAllRelevantCells(_ f: (Coordinate) -> ()) {
        for x in -5...5 {
            for y in -5...5 {
                let coordinate = Coordinate(x: x, y: y)
                f(coordinate)
            }
        }
    }

    private func countLiveNeighbours(of coordinate: Coordinate) -> Int {
        return liveCells.filter(isNeighbour(of: coordinate)).count
    }

    private func isNeighbour(of coordinate: Coordinate) -> (Coordinate) -> Bool {
        return { other in coordinate.distance(to: other) == 1 }
    }

    public func state(at coordinate: Coordinate) -> CellState {
        return liveCells.contains(coordinate)
            ? .live
            : .dead
    }
}

public struct Coordinate: Hashable {
    let x: Int
    let y: Int

    public init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }

    /// This is the Chebyshev distance
    /// i.e., the max of the distance in each dimension
    func distance(to other: Coordinate) -> Int {
        return max(abs(x - other.x), abs(y - other.y))
    }
}

public enum CellState {
    case dead, live
}
