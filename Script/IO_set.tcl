###############################################################
# PLACE PORT / PIN ASSIGNMENT - Single_Cycle_Top
###############################################################

# Clock - cạnh TOP, layer riêng cho clock (Metal4 để tránh đụng bus data)
editPin -pin clk \
    -layer Metal4 -side LEFT \
    -pinWidth 1 -pinDepth 1 \
    -spreadType CENTER -fixOverlap 1 \
	 -fixedPin 

# Reset - cùng cạnh TOP, tách riêng khỏi clock
editPin -pin reset \
    -layer Metal4 -side LEFT \
    -pinWidth 0.5 -pinDepth 1 \
    -spreadType CENTER -fixOverlap 1 \
	 -fixedPin

# WriteData[31:0] - bus dữ liệu ghi, đặt cạnh RIGHT
editPin -pin {WriteData[*]} \
    -layer Metal3 -side RIGHT \
    -pinWidth 0.2 -pinDepth 1 \
    -spacing 1.0 -spreadType CENTER -fixOverlap 1 \
	 -fixedPin

# DataAddr[31:0] - bus địa chỉ, đặt cạnh LEFT
editPin -pin {DataAddr[*]} \
    -layer Metal3 -side LEFT \
    -pinWidth 0.5 -pinDepth 1 \
    -spacing 2.0 -spreadType CENTER -fixOverlap 1 \
	 -fixedPin

# MemWrite - cạnh BOTTOM
editPin -pin MemWrite \
    -layer Metal4 -side BOTTOM \
    -pinWidth 0.5 -pinDepth 1 \
    -spreadType CENTER -fixOverlap 1 \
	 -fixedPin
