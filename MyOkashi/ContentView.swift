import SwiftUI


struct ContentView: View {
    var okashiDataList = OkashiData()
    @State var inputText = ""
    @State var isShowSafari = false

    var body: some View {
        VStack {
            TextField("キーワード",
                      text: $inputText,
                      prompt: Text("キーワードを入力してください"))
            .onSubmit {
                okashiDataList.searchOkashi(keyword: inputText)
            }
            .submitLabel(.search)
            .padding()

            List(okashiDataList.okashiList) { okashi in
                Button {
                    okashiDataList.okashiLink = okashi.link
                    isShowSafari.toggle()
                } label: {
                    HStack {
                        AsyncImage(url: okashi.image) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(height: 40)
                        } placeholder: {
                            ProgressView()
                        }
                        Text(okashi.name)
                    }
                }
            }
            .sheet(isPresented: $isShowSafari, content: {
                SafariView(url: okashiDataList.okashiLink!)
                    .ignoresSafeArea(edges: [.bottom])
            })
        }
    }
}

#Preview {
    ContentView()
}
