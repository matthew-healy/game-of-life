import XCTest
import life

final class lifeTests: XCTestCase {
    static var allTests = [
        ("Live cell with no neighbours dies", test_whenLiveCellHasNoNeighbours_itDies),
        ("Dead cell with 2 neighbours revives", test_whenDeadCellHasTwoNeighbours_itRevives),
        ("Dead cell with 3 neighbours revives", test_whenDeadCellHasThreeNeighbours_itRevives)
    ]

    private var game: Game!

    override func setUp() {
        super.setUp()
        game = Game()
    }

    override func tearDown() {
        game = nil
        super.tearDown()
    }

    func test_whenLiveCellHasNoNeighbours_itDies() {
        setLive(at: [(0, 0)])
        game.nextGeneration()
        XCTAssertEqual(.dead, game.state(atCoordinate: (x: 0, y: 0)))
    }

    func test_whenDeadCellHasTwoNeighbours_itRevives() {
        setLive(at: [(0, 1), (1, 0)])
        game.nextGeneration()
        XCTAssertEqual(.live, game.state(atCoordinate: (x: 0, y: 0)))
    }

    func test_whenDeadCellHasThreeNeighbours_itRevives() {
        setLive(at: [(0, 1), (1, 1), (1, 0)])
        game.nextGeneration()
        XCTAssertEqual(.live, game.state(atCoordinate: (x: 0, y: 0)))
    }

    private func setLive(at coordinates: [(Int, Int)]) {
        coordinates.map(Coordinate.init)
            .forEach { game.setLive(at: $0) }
    }
}
