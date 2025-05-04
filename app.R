library(shiny)
library(shinythemes)
library(readxl)

ui <- fluidPage(
  theme = shinytheme("flatly"),  # Use a Bootstrap theme
  titlePanel("Analisis Pretest-Posttest Pelatihan"),
  
  sidebarLayout(
    sidebarPanel(
      h3("Masukkan Informasi Pelatihan"),
      # Collapsible input sections
      tabsetPanel(
        tabPanel("1. Detail Pelatihan",
                 textInput("training_name", "Nama Pelatihan", value = "Pelatihan Akuntansi"),
                 dateInput("start_date", "Tanggal Awal Pelatihan", format = "dd-mm-yyyy"),
                 dateInput("end_date", "Tanggal Akhir Pelatihan", format = "dd-mm-yyyy"),
                 textInput("participants", "Jumlah Peserta", value = "30")
        ),
        tabPanel("2. Informasi Mitra & Lokasi",
                 textInput("organizer", "Penyelenggara", value = "Politeknik Keuangan Negara STAN"),
                 textInput("partner", "Mitra", value = "Pemerintah Kabupaten Sudimampir"),
                 textInput("location", "Lokasi", value = "Kampus Politeknik Keuangan Negara STAN")
        ),
        tabPanel("3. Upload File",
                 fileInput("source_file", "File Sumber", accept = c(".xlsx"))
        )
      ),
      hr(),
      actionButton("submit", "Submit", class = "btn-primary"),
      downloadButton("downloadReport", "Download Report", class = "btn-success")
    ),
    
    mainPanel(
      h3("Data Pelatihan"),
      wellPanel(
        verbatimTextOutput("result")
      ),
      h3("Data Unggahan"),
      tableOutput("tabel"),
      conditionalPanel(
        condition = "input.source_file == null",
        p("Upload a file to preview data.", style = "color: grey;")
      )
    )
  )
)

server <- function(input, output, session) {
  # Set locale to Indonesian for correct date formatting
  Sys.setlocale("LC_TIME", "id_ID.UTF-8")
  
  observeEvent(input$submit, {
    if (is.null(input$source_file)) {
      # Show a warning if no file is uploaded
      showNotification("Harap unggah file sebelum mengklik Submit!", type = "error")
    } else {
      # Render the result with date formatted in Indonesian
      output$result <- renderText({
        start_date <- format(input$start_date, "%d %B %Y")  # Format in Indonesian
        end_date <- format(input$end_date, "%d %B %Y")      # Format in Indonesian
        paste(
          "Training Name:", input$training_name, "\n",
          "Training Start Date:", start_date, "\n",
          "Training End Date:", end_date, "\n",
          "Participants:", input$participants, "\n",
          "Organizer:", input$organizer, "\n",
          "Partner:", input$partner, "\n",
          "Location:", input$location
        )
      })
      
      # Render the uploaded table
      output$tabel <- renderTable({
        file_path <- input$source_file$datapath
        tab <- read_excel(file_path, col_types = "text")
        return(tab)
      })
    }
  })
  
  output$downloadReport <- downloadHandler(
    filename = function() {
      paste('Laporan Analisis Pretest-Posttest ', input$training_name, ".", sep = '', 'docx')
    },
    content = function(file) {
      src <- normalizePath('Prepost Reboot.Rmd')
      owd <- setwd(tempdir())
      on.exit(setwd(owd))
      file.copy(src, c('Prepost Reboot.Rmd'), overwrite = TRUE)
      library(rmarkdown)
      library(knitr)
      out <- render('Prepost Reboot.Rmd', 
                    "word_document",
                    params = list(
                      filename = input$source_file$datapath,
                      nama = input$training_name,
                      penyelenggara = input$organizer,
                      mitra = input$partner,
                      tanggalmulai = input$start_date,
                      tanggalselesai = input$end_date,
                      lokasi = input$location
                    )
      )
      file.rename(out, file)
    }
  )
}

shinyApp(ui = ui, server = server)
