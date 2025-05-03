// Fact.res
%%raw("import '../../input.css'")

type myFact = {id: string, question: string, answer: string}
type colorRGB = {r: int, g: int, b: int}

let myFacts = [
  {id: "fact1", question: "My nickname is", answer: "Tata"},
  {id: "fact2", question: "My hometown is", answer: "Hat Yai, Songkhla, Thailand"},
  {id: "fact3", question: "My favourite food is", answer: "Papaya salad (Som tum)"},
  {id: "fact4", question: "My favourite song is", answer: "Get Lucky"},
  {id: "fact5", question: "My favourite serie is", answer: "Hometown Cha-Cha-Cha"},
  {id: "fact6", question: "My favourite book is", answer: "Atomic Habits"},
  {id: "fact7", question: "My favourite sport is", answer: "Football"},
  {id: "fact8", question: "My favourite football team is", answer: "Manchester United"},
  {id: "fact9", question: "My favourite footballer is", answer: "Cristiano Ronaldo"},
]

@react.component
let make = () => {
  let componentToHex = c => {
    // Change (0-256) to Hexadecimal number (0-FF)
    let hex = Js.Int.toStringWithRadix(c, ~radix=16)
    Js.String.length(hex) == 1 ? "0" ++ hex : hex
  }

  let rgbToHex = (r, g, b) => {
    "#" ++ componentToHex(r) ++ componentToHex(g) ++ componentToHex(b)
  }

  let generateRandomColor = (mix: colorRGB) => {
    let red = ref(Js.Math.random_int(0, 256))
    let green = ref(Js.Math.random_int(0, 256))
    let blue = ref(Js.Math.random_int(0, 256))

    // Mix the color
    red := (red.contents + mix.r) / 2
    green := (green.contents + mix.g) / 2
    blue := (blue.contents + mix.b) / 2

    let color = rgbToHex(red.contents, green.contents, blue.contents)
    color
  }

  let items = myFacts->Js.Array2.mapi((fact, index) => {
    // Mix with white color to make a lighter color
    let randomHex = generateRandomColor({r: 255, g: 255, b: 255})
    <div style={ReactDOM.Style.make(~backgroundColor=`${randomHex}`, ())} className="transition mx-5 my-2 p-2 rounded-lg min-w-[300px] drop-shadow-lg hover:drop-shadow-2xl hover:scale-110" key={fact.id}>
      <p>
        <strong> {("Question " ++ Belt.Int.toString(index + 1) ++ ": ")->React.string} </strong>
        {React.string(fact.question)}
      </p>
      <p> {React.string("Answer: " ++ fact.answer)} </p>
    </div>
  })

  <section className="max-w-[1100px] mx-auto">
    <h2 className="text-center text-xl font-bold mt-10 mb-2"> {React.string("9 Facts About Me")} </h2>
    <div className="flex flex-wrap justify-center"> {items->React.array} </div>
  </section>
}
