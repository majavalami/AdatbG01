{
    "metadata": {
        "kernelspec": {
            "name": "SQL",
            "display_name": "SQL",
            "language": "sql"
        },
        "language_info": {
            "name": "sql",
            "version": ""
        }
    },
    "nbformat_minor": 2,
    "nbformat": 4,
    "cells": [
        {
            "cell_type": "code",
            "source": [
                "USE WebShop;\r\n",
                "\r\n",
                "-- tábla létrehozása\r\n",
                "CREATE TABLE Ugyfel_Masked\r\n",
                "(\r\n",
                "    [LOGIN] VARCHAR(32) PRIMARY KEY,\r\n",
                "    EMAIL VARCHAR(64)\r\n",
                "        MASKED WITH (FUNCTION = 'email()')\r\n",
                "        NOT NULL,\r\n",
                "    NEV VARCHAR(64)\r\n",
                "        MASKED WITH (FUNCTION = 'partial(1,\"XXXX\",1)')\r\n",
                "        NOT NULL,\r\n",
                "    SZULEV NUMERIC(4)\r\n",
                "        MASKED WITH (FUNCTION = 'random(1967,2000)')\r\n",
                "        NULL,\r\n",
                "    NEM VARCHAR(1) NULL,\r\n",
                "    CIM VARCHAR(128) NULL\r\n",
                ");\r\n",
                "\r\n",
                "-- tábla feltöltése\r\n",
                "INSERT INTO Ugyfel_Masked ([LOGIN], EMAIL, NEV, SZULEV, NEM, CIM)\r\n",
                "SELECT [LOGIN], EMAIL, NEV, SZULEV, NEM, CIM\r\n",
                "FROM Ugyfel;\r\n",
                "\r\n",
                "-- felhasználó létrehozása\r\n",
                "CREATE USER MaskedUser WITHOUT LOGIN;\r\n",
                "GRANT SELECT ON Ugyfel_Masked TO MaskedUser;\r\n",
                "\r\n",
                "-- lekérdezés\r\n",
                "EXECUTE AS USER = 'MaskedUser';\r\n",
                "    SELECT *\r\n",
                "    FROM Ugyfel_Masked;\r\n",
                "REVERT;"
            ],
            "metadata": {
                "azdata_cell_guid": "c7c60fe3-227f-41ec-bd68-74a582461623",
                "language": "sql"
            },
            "outputs": [
                {
                    "output_type": "error",
                    "evalue": "Msg 262, Level 14, State 1, Line 4\r\nCREATE TABLE permission denied in database 'webshop'.",
                    "ename": "",
                    "traceback": []
                },
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "Total execution time: 00:00:00.009"
                    },
                    "metadata": {}
                }
            ],
            "execution_count": 1
        }
    ]
}