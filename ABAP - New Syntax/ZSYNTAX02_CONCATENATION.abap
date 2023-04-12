*&---------------------------------------------------------------------*
*& Report ZSYNTAX02_CONCATENATION
*&---------------------------------------------------------------------*
*& Contatenate Operator
*&---------------------------------------------------------------------*
REPORT zsyntax02_concatenation.

" Inline Declaration
DATA(text1) = 'New'.
DATA(text2) = 'ABAP'.
DATA(text3) = 'Syntax'.

*CONCATENATE text1 text2 text3 INTO DATA(gv_concat) SEPARATED BY space.

" Space issues (!)
DATA(gv_concat) = |{ text1 && text2 && text3 }|.
DATA(gv_concat2) = |{ text1 && '' && text2 && '' && text3 }|.

" Separated by space
DATA(gv_concat3) = |{ text1 }| & | | & |{ text2 }| & | | & |{ text3 }|.
DATA(gv_concat4) = |{ text1 }| && | | && |{ text2 }| && | | && |{ text3 }|.
DATA(gv_concat5) = |{ text1 && ` ` && text2 && ` ` && text3 }|.

WRITE:/ gv_concat.
WRITE:/ gv_concat2.
WRITE:/ gv_concat3.
WRITE:/ gv_concat4.
WRITE:/ gv_concat5.

ULINE.

PARAMETERS: p_value1 TYPE string DEFAULT '22',
            p_value2 TYPE string DEFAULT '55'.

DATA(gv_text) = |Parameter Value 1 = { p_value1 } <-> | && |Parameter Value 2 = { p_value2 }| .
WRITE: gv_text.