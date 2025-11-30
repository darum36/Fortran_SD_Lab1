module IO_Process
   
   use Environment
   use Config
   
   implicit none

contains

   ! Получение кол-ва учеников
   function count_of_students(filename) result(n_stud)
      character(*), intent(in) :: filename
      integer                  :: n_stud
      integer                  :: In, IO
      
      n_stud = 0

      open(newunit=In, file=filename, action='read')
         read(In, *, iostat=IO)
         do while(IO == 0)
            read(In, *, iostat=IO)
            n_stud = n_stud + 1
         end do
      close (In)

   end function count_of_students

   ! создание системного файла
   subroutine create_data_file(Input_File, Output_File)
      
      character(*), intent(in) :: Input_File, Output_File

      type(student)            :: Stud
      integer                  :: In, Out, IO, i, Stud_Amount

      Stud_Amount = count_of_students(Input_File)

      open(file=Input_File, encoding=E_, newunit=In)

         open(file=Output_File, form='unformatted', &
              newunit=Out, access='direct', recl=RECL)

            do i = 1, Stud_Amount
               read  (In, S_FORMAT, iostat=IO) Stud%Surname, Stud%Initials, & 
                                               Stud%Year
               write (Out, iostat=IO, rec=i)   Stud
            end do

         close (Out)
      
      close (In)

   end subroutine create_data_file

   ! получение списка всей группы студентов
   function read_student_list(Dat_file) result(Group)
      
      character(*), intent(in)   :: Dat_file
      type(student), allocatable :: Group(:)

      integer                    :: In, IO, Stud_Amount

      Stud_Amount = count_of_students(IN_FILE)
      allocate(Group(Stud_Amount))

      open(file=Dat_file, form='unformatted', newunit=In, &
           access='direct', recl=RECL * Stud_Amount)
         read (In, iostat=IO, rec=1) Group
      close (In)

   end function read_student_list

   ! запись исходной группы  
   subroutine write_student_list(Output_File, Group, Message)

      type(student), intent(in) :: Group(:)
      character(*),  intent(in) :: Output_File, Message
            
      integer                   :: Out, IO, i

      open  (file=Output_File, encoding=E_, newunit=Out)
      write (Out, '(/a)') Message   
      write (Out, S_FORMAT, iostat=IO) (Group(i)%Surname, Group(i)%Initials, &
                                              Group(i)%Year, i = 1, Size(Group)) 
      close (Out)

   end subroutine write_student_list

   ! запись одного стундента по индексу
   subroutine write_student_by_index(Output_File, Stud, Message)
      
      type(student), intent(in) :: Stud
      character(*),  intent(in) :: Output_File, Message

      integer                   :: Out, IO

      open (file=Output_File, encoding=E_, newunit=Out, position='append')
         write (Out, '(/a)') Message
         write (Out, S_FORMAT, iostat=IO) Stud%Surname, Stud%Initials, &
                                          Stud%Year
      close (Out)

   end subroutine write_student_by_index 

end module IO_Process   
