public struct Game {
    private var liveCells: Set<Coordinate> = []
    private var cellState: CellState = .dead

    public init() {}

    public mutating func setLive(at coordinate: Coordinate) {
        liveCells.insert(coordinate)
    }

    public mutating func nextGeneration() {
        let shouldBeRevived = liveCells.count == 2 || liveCells.count == 3
        cellState = shouldBeRevived ? .live : .dead
    }

    public func state(atCoordinate: (x: Int, y: Int)) -> CellState {
        return cellState
    }
}

public struct Coordinate: Hashable {
    let x: Int
    let y: Int

    public init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
}

public enum CellState {
    case dead, live
}
