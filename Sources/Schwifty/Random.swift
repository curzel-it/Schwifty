import Foundation

public enum Random {
    public static func coinFlip() -> Bool {
        probability(oneIn: 2)
    }

    public static func rollDice() -> Int {
        (1 ... 6).randomElement() ?? 3
    }

    public static func probability(oneIn possibilities: Int) -> Bool {
        guard possibilities > 0 else { return false }
        guard possibilities > 1 else { return true }
        return (1 ... possibilities).randomElement() == 1
    }
}
