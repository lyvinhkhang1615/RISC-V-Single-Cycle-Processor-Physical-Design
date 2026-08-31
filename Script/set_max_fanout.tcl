#Bật interactive constraint mode cho tất cả các mode đang active:

set_interactive_constraint_modes [all_constraint_modes -active]

set_max_fanout 30 [current_design]

#Kiểm tra xem hiện có đúng là đã setup MMMC (dù mình từng nghĩ bạn dùng classic flow không MMMC) hay không:

all_constraint_modes
all_analysis_views
