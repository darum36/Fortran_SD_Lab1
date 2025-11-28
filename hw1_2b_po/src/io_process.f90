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

   subroutine read_students_list (Input_File, Surnames, Initials, Year)

      character(*),                     intent(in)  :: Input_File 
      character(kind=CH_), allocatable, intent(out) :: Surnames(:,:)
      character(kind=CH_), allocatable, intent(out) :: Initials(:,:)
      integer,             allocatable, intent(out) :: Year(:)
      
      integer                                       :: In, IO, i, Stud_Amount

      character(FILE_SURNAME_LEN, kind=CH_)         :: Sur_na
      character(FILE_INITIALS_LEN, kind=CH_)        :: Ini_na

      Stud_Amount = count_of_students(Input_File)
      allocate (Surnames(Stud_Amount, SURNAME_LEN), &
                Initials(Stud_Amount, INITIALS_LEN), &
                Year(Stud_Amount))

      open (file=Input_File, encoding=E_, newunit=In)
         do i = 1, Stud_Amount
            read (In, S_FORMAT, iostat=IO) Sur_na, Ini_na, Year(i)
            Surnames(i, :) = Transfer(Sur_na, Surnames(i, :))
            Initials(i, :) = Transfer(Ini_na, Initials(i, :))
         end do
      close (In)
  
   end subroutine read_students_list
  
   subroutine write_student_list(Output_File, Surnames, Initials, Year, Message)

      character(*),        intent(in)        :: Output_File, Message
      character(kind=CH_), intent(in)        :: Surnames(:,:)
      character(kind=CH_), intent(in)        :: Initials(:,:)
      integer,             intent(in)        :: Year(:)

      integer                                :: Out, IO, i

      character(FILE_SURNAME_LEN, kind=CH_)  :: Surname_t
      character(FILE_INITIALS_LEN, kind=CH_) :: Initials_t

      open(file=Output_File, encoding=E_, newunit=Out)
         write(Out, '(/a)') Message
         do i = 1, size(Year)
            Surname_t  = Transfer(Surnames(i, 1:FILE_SURNAME_LEN),  Surname_t)
            Initials_t = Transfer(Initials(i, 1:FILE_INITIALS_LEN), Initials_t)
            write(Out, S_FORMAT, iostat=IO) &
                  Surname_t, & 
                  Initials_t, &
                  Year(i)
         end do
      close (Out)

   end subroutine write_student_list

   subroutine write_student_by_index(Output_File, Surnames, Initials, Year, Stud_ind, Message)

      character(*),        intent(in)        :: Output_File, Message 
      character(kind=CH_), intent(in)        :: Surnames(:,:)
      character(kind=CH_), intent(in)        :: Initials(:,:)
      integer,             intent(in)        :: Year(:)
      integer,             intent(in)        :: Stud_ind
      
      integer                                :: Out, IO

      character(FILE_SURNAME_LEN, kind=CH_)  :: Surname_t
      character(FILE_INITIALS_LEN, kind=CH_) :: Initials_t

      open(file=Output_File, encoding=E_, newunit=Out, position='append')
         write(Out, '(/a)') Message
         Surname_t  = Transfer(Surnames(Stud_ind, 1:FILE_SURNAME_LEN),  Surname_t)
         Initials_t = Transfer(Initials(Stud_ind, 1:FILE_INITIALS_LEN), Initials_t)
         write(Out, S_FORMAT, iostat=IO) &
               Surname_t, Initials_t, Year(Stud_ind) 
      close (Out)

   end subroutine write_student_by_index
   
end module IO_Process   
