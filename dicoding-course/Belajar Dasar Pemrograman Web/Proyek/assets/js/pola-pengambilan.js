async function getData() {
  const response = await fetch("./assets/js/daftar-matkul.json");

  if (response.status !== 200) {
    throw new Error("cannot fetch data");
  }

  const data = await response.json();

  const array = data.values;

  const result = array.filter(checkKDMK);

  function checkKDMK(item) {
    return item.semester % 2 == 1;
  }

  console.log(result);
  return result;
}
getData().then((result) => {
  const data = result;
  const eleDaftarMataKuliah = document.getElementById("daftar-mata-kuliah");
  console.log(data);

  let item = "";
  for (let i = 0; i < data.length; i++) {
    const {
      kode_mata_kuliah,
      nama_mata_kuliah,
      semester,
      kategori,
      sks,
      jenis,
    } = data[i];
    item += `<article class="card-matkul">`;
    item += `<h3 class="category-header">${nama_mata_kuliah}</h3>`;
    item += `<div class="category">`;
    item += `<p class="category-item">${sks} SKS</p>`;
    item += `<p class="category-item">${jenis}</p>`;
    item += `<p class="category-item">${kategori}</p>`;
    item += `<p class="category-item">${kode_mata_kuliah}</p>`;
    item += `<p class="category-item">Semester ${semester}</p>`;
    item += `</div>`;
    item += `</article>`;
  }
  // console.log(item);
  // console.log(eleDaftarMataKuliah);
  eleDaftarMataKuliah.innerHTML = item;
});

// for (let i = 0; i < 10; i++) {
//   document.write(`<div class="card">
//   <h3 class="category-header">Bahasa Inggris</h3>
//   <div class="category">
//     <p class="category-item">2 SKS</p>
//     <p class="category-item">Wajib</p>
//     <p class="category-item">T</p>
//     <p class="category-item">N201702</p>
//   </div>
// </div>`);
// }
