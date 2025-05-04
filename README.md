# Analisis Pretest-Posttest Pelatihan

Aplikasi ini adalah alat bantu berbasis web untuk menganalisis hasil pretest dan posttest peserta pelatihan. Dikembangkan menggunakan R Markdown dan Shiny, aplikasi ini menghasilkan laporan otomatis dalam bahasa Indonesia yang mencakup statistik deskriptif, uji normalitas, serta uji signifikansi (paired t-test atau Wilcoxon signed-rank test, tergantung asumsi distribusi data).

## Fitur Utama

* **Input fleksibel** berupa file Excel yang berisi skor pretest dan posttest peserta pelatihan.
* **Visualisasi otomatis** berupa histogram perubahan skor dan density plot.
* **Uji asumsi normalitas** menggunakan Shapiro-Wilk test.
* **Pemilihan uji statistik otomatis**:

  * Jika data selisih berdistribusi normal → *paired t-test*.
  * Jika tidak normal → *Wilcoxon signed-rank test*.
* **Pelaporan otomatis** dalam format HTML atau Word, dilengkapi dengan narasi yang mudah dipahami dalam bahasa Indonesia.

## Teknologi yang Digunakan

* **Bahasa Pemrograman**: R
* **Paket R**: `readxl`, `ggplot2`, `dplyr`, `tidyr`, `CTT`, `knitr`
* **Antarmuka Web**: Shiny

## Cara Menjalankan

Aplikasi dapat dijalankan dengan dua cara:

1. **Secara lokal:**  
   Jalankan `app.R` menggunakan RStudio atau R Console.

2. **Secara daring:**  
   Gunakan versi yang telah dideploy di ShinyApps.io melalui tautan berikut:  
   [http://myprabowo.shinyapps.io/Prepost/](http://myprabowo.shinyapps.io/Prepost/)


## Format Dataset

File Excel harus memiliki tiga kolom:

| ID  | Pretest | Posttest |
| --- | ------- | -------- |
| 001 | 55      | 75       |
| 002 | 60      | 65       |
| ... | ...     | ...      |

## Lisensi

Proyek ini didistribusikan di bawah lisensi [MIT](https://opensource.org/licenses/MIT).

---
