// FileSizeCalculation.res
%%raw("import '../../../../input.css'")

let files = `my.song.mp3 11b
greatSong.flac 1000b
not3.txt 5b
video.mp4 200b
game.exe 100b
mov!e.mkv 10000b`

let fileSizeCalculation = %raw(`
  function (fileList) {
    let resultSize = [0, 0, 0, 0];
    fileList.split("\n").forEach((list) => {
      const temp = list.split(" ");
      const typeArr = temp[0].split(".");
      const type = typeArr[typeArr.length - 1];
      const size = temp[1].split("b");
      if (type === "mp3" || type === "aac" || type === "flac") {
        resultSize[0] += parseInt(size[0]);
      } else if (type === "jpg" || type === "bmp" || type === "gif") {
        resultSize[1] += parseInt(size[0]);
      } else if (type === "mp4" || type === "avi" || type === "mkv") {
        resultSize[2] += parseInt(size[0]);
      } else {
        resultSize[3] += parseInt(size[0]);
      }
    });

    let result = [];
    result.push("music " + resultSize[0] + "b");
    result.push("images " + resultSize[1] + "b");
    result.push("movies " + resultSize[2] + "b");
    result.push("other " + resultSize[3] + "b");
    return result;
  }
`)

@react.component
let make = () => {
  let (filesList, setfilesList) = React.useState(_ => files)
  let handleFilesListChange = event => {
    let value = ReactEvent.Form.currentTarget(event)["value"]
    setfilesList(_ => value)
  }

  let fileSizeCalitems = fileSizeCalculation(filesList)->Js.Array2.mapi((file, index) => {
    <li key={index->Belt.Int.toString}> {React.string(file)} </li>
  })

  <section>
    <h2 className="text-center text-xl font-bold mt-10 mb-2">
      {React.string("File Size Calculation Challenge")}
    </h2>
    <div className="flex flex-wrap max-w-[1200px] mx-auto justify-around">
      <div className="mx-5 mb-3">
        <h3 className="max-w-[350px]">
          {React.string(
            "You want to know how many bytes of memory each file type is consuming. Each file has a name, and the part of the name after the last dot is called the file extension, which identifies what type of file it is. We distinguish four broad types of file:",
          )}
        </h3>
        <ul className="max-w-[300px] mb-3">
          <li> {React.string("• music (only extensions: mp3, aac, flac)")} </li>
          <li> {React.string("• Image (only extensions: jpg, bmp.gif)")} </li>
          <li> {React.string("• movie (only extensions: mp4, avi, mkv)")} </li>
          <li> {React.string("• other (all other extensions; for example: 7z, txt, zip)")} </li>
        </ul>
        <p className="pb-2"> {React.string("Input a list of files")} </p>
        <textarea
          style={ReactDOM.Style.make(~resize="none", ())}
          className="p-2 rounded-lg"
          value={filesList}
          rows=5
          cols=30
          id="filesListInput"
          onChange={handleFilesListChange}
        />
      </div>
      <pre
        className="transition max-w-[500px] h-[400px] mx-5 mb-3 p-5 overflow-scroll bg-red-300 rounded-xl drop-shadow-lg hover:drop-shadow-2xl">
        <code>
          {React.string(`function (fileList) {
  let resultSize = [0, 0, 0, 0];
  fileList.split("\\n").forEach((list) => {
    const temp = list.split(" ");
    const typeArr = temp[0].split(".");
    const type = typeArr[typeArr.length - 1];
    const size = temp[1].split("b");
    if (type === "mp3" || type === "aac" || type === "flac") {
      resultSize[0] += parseInt(size[0]);
    } else if (type === "jpg" || type === "bmp" || type === "gif") {
      resultSize[1] += parseInt(size[0]);
    } else if (type === "mp4" || type === "avi" || type === "mkv") {
      resultSize[2] += parseInt(size[0]);
    } else {
      resultSize[3] += parseInt(size[0]);
    }
  });

  let result = [];
  result.push("music " + resultSize[0] + "b");
  result.push("images " + resultSize[1] + "b");
  result.push("movies " + resultSize[2] + "b");
  result.push("other " + resultSize[3] + "b");
  return result;
}
`)}
        </code>
      </pre>
      {fileSizeCalitems->Js.Array2.length != 0
        ? <div
            className="transition min-w-[150px] h-[150px] mx-5 mb-3 p-5 bg-red-200 rounded-xl overflow-y-scroll drop-shadow-lg hover:drop-shadow-2xl">
            {fileSizeCalitems->React.array}
          </div>
        : <> </>}
    </div>
  </section>
}
