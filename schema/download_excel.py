#!/usr/bin/env python3

import mysql.connector
import pandas as pd
import io
import sys

def main():
    conn = mysql.connector.connect(
        host="localhost",
        user="root",
        password="bdmhyuntae",
        database="homework2"
    )
    cursor = conn.cursor()

    query = """
        SELECT ticker, date, close, exchange
        FROM price
    """
    cursor.execute(query)
    rows = cursor.fetchall()
    columns = [desc[0] for desc in cursor.description]

    cursor.close()
    conn.close()

    df = pd.DataFrame(rows, columns=columns)
    output = io.BytesIO()
    df.to_excel(output, index=False)
    excel_data = output.getvalue()

    sys.stdout.write("Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet\r\n")
    sys.stdout.write("Content-Disposition: attachment; filename=result.xlsx\r\n\r\n")
    sys.stdout.flush()
    sys.stdout.buffer.write(excel_data)

if __name__ == "__main__":
    try:
        main()
    except Exception as e:
        sys.stdout.write("Content-Type: text/plain\r\n\r\n")
        sys.stdout.write("Error generating Excel file:\n")
        sys.stdout.write(str(e))
