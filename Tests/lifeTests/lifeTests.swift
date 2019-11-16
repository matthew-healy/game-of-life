import XCTest
import life

final class lifeTests: XCTestCase {
    static var allTests = [
        ("Live cell with no neighbours dies", test_whenLiveCellHasNoNeighbours_itDies),
        ("Live cell with 2 neighbours survives", test_whenLiveCellHasTwoNeighbours_itSurvives),
        ("Live cell with 3 neighbours survives", test_whenLiveCellHasThreeNeighbours_itSurvives),
        ("Dead cell with 3 live non-neighbours stays dead", test_whenDeadCellHas3LiveNonNeighbours_itStaysDead),
        ("Live cell with 4 or more live neighbours dies", test_whenLiveCellHasMoreThanFourLiveNeighbours_itDies)
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
        XCTAssertEqual(.dead, game.state(at: Coordinate(x: 0, y: 0)))
    }

    func test_whenLiveCellHasTwoNeighbours_itSurvives() {
        setLive(at: [(0, 0), (0, 1), (1, 0)])
        game.nextGeneration()
        XCTAssertEqual(.live, game.state(at: Coordinate(x: 0, y: 0)))
    }

    func test_whenLiveCellHasThreeNeighbours_itSurvives() {
        setLive(at: [(0, 0), (0, 1), (1, 1), (1, 0)])
        game.nextGeneration()
        XCTAssertEqual(.live, game.state(at: Coordinate(x: 0, y: 0)))
    }

    func test_whenDeadCellHas3LiveNonNeighbours_itStaysDead() {
        setLive(at: [(0, 1), (1, 0), (1, 1)])
        game.nextGeneration()
        XCTAssertEqual(.dead, game.state(at: Coordinate(x: 5, y: 9)))
    }

    func test_whenLiveCellHasMoreThanFourLiveNeighbours_itDies() {
        let baseTest = [(0, 0), (-1, 0), (0, -1), (1, 0), (0, 1)]
        for test: [(Int, Int)] in [
            baseTest,
            baseTest + [(1, 1)],
            baseTest + [(1, 1), (-1, -1)],
            baseTest + [(1, 1), (-1, -1), (1, -1)],
            baseTest + [(1, 1), (-1, -1), (1, -1), (-1, 1)],
        ] {
            setLive(at: test)
            game.nextGeneration()
            let message = "Cell with \(test.count - 1) neighbours did not die"
            XCTAssertEqual(.dead, game.state(at: Coordinate(x: 0, y: 0)), message)
        }
    }

    private func setLive(at coordinates: [(Int, Int)]) {
        coordinates.map(Coordinate.init)
            .forEach { game.setLive(at: $0) }
    }
}
