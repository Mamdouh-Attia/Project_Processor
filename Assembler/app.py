import customtkinter as ct
from tkinter.ttk import *
from tkinter.filedialog import askopenfile
import time
from Code.assembler import *

ct.set_appearance_mode("dark")
ct.set_default_color_theme("dark-blue")


root = ct.CTk()
root.geometry("700x200")
root.title("Convert Assembly to Binary File")

# Frame
frame = ct.CTkFrame(master=root)
frame.pack(pady=20, padx=60, fill="both", expand=True)

radio_var = ct.IntVar()
model = None

data = {}


def open_file(which_file):
    my_file = askopenfile(mode='r')
    if (which_file == 0):  # input file
        data[0] = my_file.name

    if (which_file == 1):  # output file
        data[1] = my_file.name

    return


def do_work(data):
    assembler(data)
    progressBar = ct.CTkProgressBar(
        master=frame,
        orientation="horizontal",
        width=300,
        height=20,
        mode='determinate'
    )
    progressBar.place(relx=0.2, rely=0.8, anchor="w")
    progressBar.start()
    for i in range(2):
        frame.update_idletasks()
        time.sleep(1)
    progressBar.destroy()
    ct.CTkLabel(master=frame, text='Converted to Binary Successfully!',
                text_color="lime").place(relx=0.4, rely=0.7, anchor="w")

    return


# upload files

inputFileUpload = ct.CTkButton(
    master=frame,
    text='Choose the input file',
    command=lambda: open_file(0)
).place(relx=0.2, rely=0.2, anchor="w")

outputPath = ct.CTkButton(
    master=frame,
    text='Choose the output file',
    command=lambda: open_file(1)
).place(relx=0.8, rely=0.2, anchor="e")


startBtn = ct.CTkButton(
    master=frame,
    text='Start',
    command=lambda: do_work(data)
).place(relx=0.4, rely=0.5, anchor="w")


root.mainloop()
