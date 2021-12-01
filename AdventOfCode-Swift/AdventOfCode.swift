//
//  AdventOfCode.swift
//  Advent-of-code-Swift-Starter
//  Forked from https://github.com/Dean151/Advent-of-code-Swift-Starter
//
//  Created by Thomas DURAND.
//  Check my computing blog on https://www.thomasdurand.fr/
//

import Foundation

enum AdventOfCode {
    /// Print an helper instructions to end-user to acknoledge existing commands
    static func explain() {
        print("Advent-of-code-Swift")
        print("")
        print("./AdventOfCode-Swift --day 1 : Run day 1 solving")
        print("./AdventOfCode-Swift --all : Solve every days one after another")
        print("./AdventOfCode-Swift --help : Show this explaination: ``")
        print("")
        print("More documentation on https://github.com/Dean151/Advent-of-code-Swift-Starter")
        print("If you have problem using this template, fill Github issues ; and/or ask me on Twitter @deanatoire")
    }

    /// Will solve given day output
    static func solve(day dayNumber: Int) {
        switch dayNumber {
        case 1:
            Day01.solve()
        case 2:
            Day02.solve()
        case 3:
            Day03.solve()
        case 4:
            Day04.solve()
        case 5:
            Day05.solve()
        case 6:
            Day06.solve()
        case 7:
            Day07.solve()
        case 8:
            Day08.solve()
        case 9:
            Day09.solve()
        case 10:
            Day10.solve()
        case 11:
            Day11.solve()
        case 12:
            Day12.solve()
        case 13:
            Day13.solve()
        case 14:
            Day14.solve()
        case 15:
            Day15.solve()
        case 16:
            Day16.solve()
        case 17:
            Day17.solve()
        case 18:
            Day18.solve()
        case 19:
            Day19.solve()
        case 20:
            Day20.solve()
        case 21:
            Day21.solve()
        case 22:
            Day22.solve()
        case 23:
            Day23.solve()
        case 24:
            Day24.solve()
        case 25:
            Day25.solve()
        default:
            explain()
        }
    }
}

protocol Day {
    /// Required to run the day problem
    static func run(input: String) throws

    /// Required to propose tests
    static func test() throws
}
extension Day {
    /// Override to replace file input
    static var input: String! { nil }
}

extension Day {
    static func solve(withTimeSpan: Bool = true) {
        do {
            try test()
        } catch {
            fatalError("An error occured while executing \(Self.self).test() : \(error)")
        }

        let input: String
        if Self.input != nil {
            input = Self.input
        } else if let fileInput = try? Input.getFromFile("\(Self.self)") {
            input = fileInput
        } else {
            fatalError("No input either in (Self.self).input ; nor input file Days/\(Self.self)/input.txt")
        }

        print("Solving \(Self.self)")

        let start = DispatchTime.now()
        do {
            try run(input: input)
        } catch {
            fatalError("An error occured while executing \(Self.self).run(input:) : \(error)")
        }

        let end = DispatchTime.now()

        print("Solved \(Self.self)")
        if withTimeSpan {
            let elapsed = Double(end.uptimeNanoseconds - start.uptimeNanoseconds) / 1_000_000_000
            let formatter = NumberFormatter()
            formatter.minimumIntegerDigits = 1
            formatter.maximumFractionDigits = 3
            print("Elapsed time: \(formatter.string(from: NSNumber(value: elapsed))!)s")
        }

        print("---------------------")
    }
}

enum Errors: Error {
    case noInput
    case unparsable
    case unsolvable
}

enum Input {
    static let projectUrl = URL(fileURLWithPath: #file).deletingLastPathComponent()

    static func getFromFile(_ day: String, file: String = "input") throws -> String {
        let url = projectUrl.appendingPathComponent("Days/\(day)/\(file).txt")
        let inputData = try Data(contentsOf: url)
        guard let input = String(data: inputData, encoding: .utf8) else {
            throw Errors.noInput
        }
        // Remove last empty line, added for git by Xcode
        var components = input.components(separatedBy: .newlines)
        if let last = components.last, last.isEmpty {
            components.removeLast()
        }
        return components.joined(separator: "\n")
    }
}
