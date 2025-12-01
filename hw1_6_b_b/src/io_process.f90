module IO_Process
   
   use Environment
   use Config
   
   implicit none

contains

   function Read_class(Input_File) result(Class_list)
      
      type(student), allocatable :: Class_list
      character(*), intent(in)   :: Input_File
      
      Integer                    :: In

      open (file=Input_File, encoding=E_, newunit=In)
         call Read_Stud(In, Class_List)
      close (In)

      contains
         
         recursive subroutine Read_Stud(In, Stud)
         
            type(student), allocatable :: Stud
            integer, intent(in)        :: In

            integer                    :: IO
            
            allocate (Stud)
                
            read (In, S_FORMAT, iostat=IO) &
                  Stud%Surname, Stud%Initial, Stud%Year
            if (IO == 0) then
               call Read_Stud(In, Stud%next)
            else 
               deallocate (Stud)
            endif
         
         end subroutine Read_Stud

   end function Read_class

   subroutine Write_Class(Output_File, Class_List, Message)
      
      character(*),  intent(in)  :: Output_File, Message
      type(student), allocatable :: Class_List

      integer                    :: Out

      open (file=Output_File, encoding=E_, position='rewind', newunit=Out)
         write (out, '(/a)') Message
      close (Out)
      open (file=Output_File, encoding=E_, position='append', newunit=Out)
         call Output_Stud(Out, Class_list)
      close (Out)

      contains

         recursive subroutine Output_Stud(Out, Stud)
         
            integer,       intent(in)  :: Out
            type(student), allocatable :: Stud

            integer                    :: IO

            if(allocated(Stud)) then
               write (Out, S_FORMAT, iostat=IO) &           
                  Stud%Surname, Stud%Initial, Stud%Year
               call Output_Stud(Out, Stud%next)
            endif

         end subroutine Output_Stud

   end subroutine Write_Class

   
   subroutine Write_Student(Output_File, Stud, Message)
      
      character(*),  intent(in) :: Output_File, Message
      type(student), intent(in) :: Stud

      integer                   :: Out, IO

      open (file=Output_File, encoding=E_, position='append', newunit=Out)
         write (Out, '(/a)') Message
         write (Out, S_FORMAT, iostat=IO) Stud%Surname, Stud%Initial, Stud%Year 
      close (Out)

   end subroutine Write_Student 

end module IO_Process   
