import Foundation

public enum AsyncMapExecutionMode {
    case sequential
    case parallel
    case batched(size: Int)
}

public extension Sequence {
    func asyncMap<T>(mode: AsyncMapExecutionMode = .sequential, _ transform: @escaping (Element) async -> T) async -> [T] {
        switch mode {
        case .sequential: await asyncSequentialMap(transform)
        case .parallel: await asyncParallelMap(transform)
            
        case .batched(let size):
            await chunks(ofSize: size)
                .asyncSequentialMap {
                    await $0.asyncParallelMap(transform)
                }
                .flatMap { $0 }
        }
    }
    
    func asyncForEach(mode: AsyncMapExecutionMode = .sequential, _ operation: @escaping (Element) async -> Void) async {
        _ = await asyncMap(mode: mode, operation)
    }
    
    func asyncThrowingMap<T>(_ transform: @escaping (Element) async throws -> T) async throws -> [T] {
        var results: [T] = []
        for element in self {
            let item = try await transform(element)
            results.append(item)
        }
        return results
    }
    
    func asyncFilter(_ filter: @escaping (Element) async -> Bool) async -> [Element] {
        var results: [Element] = []
        for element in self {
            if await filter(element) {
                results.append(element)
            }
        }
        return results
    }
}

private extension Sequence {
    func asyncSequentialMap<T>(_ transform: @escaping (Element) async -> T) async -> [T] {
        var results: [T] = []
        for element in self {
            let item = await transform(element)
            results.append(item)
        }
        return results
    }
    
    func asyncParallelMap<T>(_ transform: @escaping (Element) async -> T) async -> [T] {
        var results: [T] = []
        await withTaskGroup(of: T.self) { group in
            for element in self {
                group.addTask {
                    await transform(element)
                }
            }
            
            for await result in group {
                results.append(result)
            }
        }
        return results
    }
}
