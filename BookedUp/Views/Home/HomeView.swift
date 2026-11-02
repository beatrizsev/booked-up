import SwiftUI

struct HomeView: View {
    var onAccount: (() -> Void)? = nil
    @ScaledMetric(relativeTo: .caption) private var bookWidth = 113.0

    private var greeting: String {
        switch Calendar.current.component(.hour, from: Date()) {
        case 5..<12: "Good morning,"
        case 12..<18: "Good afternoon,"
        default: "Good evening,"
        }
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text(greeting)
                            .bookedUpText(.body)
                            .foregroundStyle(AppColor.secondaryText)
                        Text(HomeSampleData.readerName)
                            .bookedUpText(.pageTitle)
                            .accessibilityAddTraits(.isHeader)
                    }
                    Spacer()
                    if let onAccount {
                        Button(action: onAccount) {
                            Image(systemName: "person.crop.circle")
                                .font(.title2)
                                .frame(width: 44, height: 44)
                        }
                        .accessibilityLabel("Demo account")
                        .accessibilityIdentifier("home.account")
                    }
                }

                CurrentlyReadingCard(reading: HomeSampleData.currentlyReading)
                ReadingChallengeCard(challenge: HomeSampleData.challenge)

                VStack(alignment: .leading, spacing: 14) {
                    Text("Because you like contemporary fiction")
                        .bookedUpText(.sectionHeading)
                        .fixedSize(horizontal: false, vertical: true)
                        .accessibilityAddTraits(.isHeader)
                    ScrollView(.horizontal) {
                        HStack(alignment: .top, spacing: 16) {
                            ForEach(HomeSampleData.recommendations) { book in
                                BookCard(book: book, width: bookWidth)
                            }
                        }
                    }
                    .scrollIndicators(.hidden)
                }

                Text("Preview · Sample reading data")
                    .bookedUpText(.caption)
                    .foregroundStyle(AppColor.secondaryText)
                    .frame(maxWidth: .infinity)
            }
            .padding(16)
            .frame(maxWidth: 640)
            .frame(maxWidth: .infinity)
        }
        .background(AppColor.background)
        .foregroundStyle(AppColor.primaryText)
        .toolbarBackground(AppColor.background, for: .tabBar)
        .toolbarBackground(.visible, for: .tabBar)
    }
}

private struct CurrentlyReadingCard: View {
    let reading: ReadingSnapshot
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("Currently Reading")
                .bookedUpText(.sectionHeading)
                .accessibilityAddTraits(.isHeader)
            if dynamicTypeSize.isAccessibilitySize {
                VStack(alignment: .leading, spacing: 16) {
                    cover
                    readingDetails
                }
            } else {
                HStack(spacing: 16) {
                    cover
                    readingDetails
                }
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(AppColor.card, in: RoundedRectangle(cornerRadius: 18))
    }

    private var cover: some View {
        BookCover(book: reading.book, width: 82, height: 128)
    }

    private var readingDetails: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(reading.book.title)
                .bookedUpText(.bookTitle)
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: dynamicTypeSize.isAccessibilitySize ? .infinity : 190, alignment: .leading)
            ReadingProgress(
                value: Double(reading.currentPage),
                total: Double(reading.totalPages),
                label: "Reading progress for \(reading.book.title)",
                detail: "\(reading.currentPage) / \(reading.totalPages) pages"
            )
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

private struct ReadingChallengeCard: View {
    let challenge: ReadingChallenge
    @ScaledMetric(relativeTo: .title2) private var countSize = 26.0
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("\(challenge.year.formatted(.number.grouping(.never))) Reading Challenge")
                .bookedUpText(.sectionHeading)
                .accessibilityAddTraits(.isHeader)

            if dynamicTypeSize.isAccessibilitySize {
                VStack(alignment: .leading, spacing: 20) {
                    ring
                    count
                }
            } else {
                HStack(spacing: 20) {
                    ring
                    count
                }
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(AppColor.card, in: RoundedRectangle(cornerRadius: 18))
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("\(challenge.year.formatted(.number.grouping(.never))) Reading Challenge")
        .accessibilityValue("\(challenge.booksRead) of \(challenge.goal) books read")
    }

    private var ring: some View {
        ReadingProgress(
            value: Double(challenge.booksRead),
            total: Double(challenge.goal),
            label: "Yearly reading goal",
            style: .ring
        )
    }

    private var count: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("\(challenge.booksRead) / \(challenge.goal)")
                .font(.system(size: countSize, weight: .semibold))
                .monospacedDigit()
            Text("books read")
                .bookedUpText(.secondaryBody)
                .foregroundStyle(AppColor.secondaryText)
        }
    }
}

#Preview {
    ContentView()
}

#Preview("Accessibility") {
    ContentView()
        .environment(\.dynamicTypeSize, .accessibility3)
}
