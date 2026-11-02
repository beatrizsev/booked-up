import Foundation

struct Book: Identifiable {
    let id: String
    let title: String
    let author: String
    let coverAsset: String
    /// Curated sample ratings, not a live service or the reader’s own rating.
    let rating: Double
}

struct ReadingSnapshot {
    let book: Book
    let currentPage: Int
    let totalPages: Int
}

struct ReadingChallenge {
    let year: Int
    let booksRead: Int
    let goal: Int
}

/// Read-only fixtures for today’s Home preview. No storage or networking.
enum HomeSampleData {
    static let readerName = "Beatriz"
    static let currentlyReading = ReadingSnapshot(
        book: Book(
            id: "cleopatra-and-frankenstein",
            title: "Cleopatra and Frankenstein",
            author: "Coco Mellors",
            coverAsset: "CleopatraAndFrankenstein",
            rating: 4.2
        ),
        currentPage: 162,
        totalPages: 384
    )
    static let challenge = ReadingChallenge(year: 2026, booksRead: 14, goal: 20)
    static let recommendations: [Book] = [
        Book(
            id: "hello-beautiful",
            title: "Hello Beautiful",
            author: "Ann Napolitano",
            coverAsset: "HelloBeautiful",
            rating: 4.2
        ),
        Book(
            id: "se-deus-me-chamar-nao-vou",
            title: "Se deus me chamar não vou",
            author: "Mariana Salomão Carrara",
            coverAsset: "SeDeusMeChamar",
            rating: 4.3
        ),
        Book(
            id: "between-heaven-and-earth",
            title: "Between Heaven and Earth: Poems about Losing & Finding Yourself",
            author: "TheFallen Poet",
            coverAsset: "BetweenHeavenAndEarth",
            rating: 4.1
        )
    ]
}
