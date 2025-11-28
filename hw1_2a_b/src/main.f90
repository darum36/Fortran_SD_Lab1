program lab_1_2a_b

   use Environment
   use Config
   use IO_Process
   use Process
   
   implicit none

   !                                              :: X(LEN, Stud_Amount)
   character(kind=CH_), allocatable               :: Surnames(:,:)
   character(kind=CH_), allocatable               :: Initials(:,:)
   integer,             allocatable               :: Year(:)

   integer                                        :: first_by_alph, youngest

   call read_students_list(IN_FILE, Surnames, Initials, Year) 
   call write_student_list(OUT_FILE, Surnames, Initials, Year, &
                           "Исходный список:")

   first_by_alph = find_first_by_alphabet(Surnames, Initials)
   call write_student_by_index(OUT_FILE, Surnames, Initials, Year, &
                               first_by_alph, "Первый по алфавиту в списке:")

   youngest = find_younger(Year)
   call write_student_by_index(OUT_FILE, Surnames, Initials, Year, &
                               youngest, "Cамый молодой в списке:")

end program lab_1_2a_b 
