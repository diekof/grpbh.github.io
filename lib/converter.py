import pdfkit
import requests
import pdfkit

session = requests.session()

# import Selenium2Library

from robot.libraries.BuiltIn import BuiltIn

def conv_to_pdf( path, nome_pdf):

    # print(path)

    se2lib = BuiltIn().get_library_instance('Selenium2Library')
    # return se2lib._current_browser()
    # s = Selenium2Library.Selenium2Library()
    url = se2lib.get_location()
    print(url)

    options =   {
                    'quiet': '', 
                    'enable-local-file-access': None,
                    'encoding': 'UTF-8',
                    'load-error-handling' : 'ignore',
                    'load-media-error-handling': 'ignore',
                }
    # pdfkit.from_url(path, nome_pdf)
    path_wkthmltopdf = b'C:\Program Files\wkhtmltopdf\\bin\wkhtmltopdf.exe'
    config = pdfkit.configuration(wkhtmltopdf=path_wkthmltopdf)
    # config = pdfkit.configuration(wkhtmltopdf=bytes(path_wkthmltopdf, 'utf8'))
    pdfkit.from_string(path, nome_pdf, configuration=config, options=options)
    # pdfkit.from_url(url, nome_pdf, configuration=config, options=options)
    # pdfkit.from_file("output.xml","rajul-pdf.pdf", configuration=config)