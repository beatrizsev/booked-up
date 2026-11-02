import SwiftUI

struct BookCover: View {
    let book: Book
    let width: CGFloat
    let height: CGFloat

    var body: some View {
        Image(book.coverAsset)
            .resizable()
            .scaledToFill()
            .frame(width: width, height: height)
            .clipShape(RoundedRectangle(cornerRadius: 4))
            .accessibilityHidden(true) // Adjacent book text supplies the accessible title.
    }
}

/// A display card; detail navigation belongs to the Discover slice.
struct BookCard: View {
    let book: Book
    var width: CGFloat = 113

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            BookCover(book: book, width: width, height: width * 1.5)
            Text(book.title)
                .bookedUpText(.caption)
                .fontWeight(.semibold)
                .lineLimit(2, reservesSpace: true)
            Text(book.author)
                .bookedUpText(.caption)
                .foregroundStyle(AppColor.secondaryText)
                .lineLimit(2, reservesSpace: true)
            Label(book.rating.formatted(.number.precision(.fractionLength(1))), systemImage: "star.fill")
                .bookedUpText(.caption)
                .foregroundStyle(AppColor.secondaryText)
        }
        .frame(width: width, alignment: .leading)
        .foregroundStyle(AppColor.primaryText)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("\(book.title), by \(book.author)")
        .accessibilityValue("Sample rating \(book.rating.formatted(.number.precision(.fractionLength(1)))) out of 5")
    }
}

#Preview {
    BookCard(book: HomeSampleData.recommendations[0])
        .padding()
        .background(AppColor.background)
}
