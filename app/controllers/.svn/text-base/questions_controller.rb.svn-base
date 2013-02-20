class QuestionsController < ApplicationController
      include ApplicationHelper
      
  # GET /questions
  # GET /questions.xml
  def index
    @questions = Question.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @questions }
    end
  end

# Displays the questions for a given survey_id
#
# Parameters:
# * survey_id : The id of the survey to display
  def survey_questions
    @survey = Survey.find( params[:survey_id])
    @questions = []
    
    #Only show survey if it is open
    #if @survey.privacy_level < Survey.close 
    @questions = Question.find(:all, :conditions => {:survey_id => params[:survey_id]}, :order => 'question_number')
    
    #end
    
      respond_to do |format|
        
        if !params[:mobile].nil?
          format.xml  #survey_questions.xml.builder # { render :xml => @questions }
        elsif has_permission(@survey.user)
          format.html { render :action => "index" }       
        else
          format.html {render "no_permission"}
        end
      end

  end

# Displays the questions for a given survey_id
#
# Parameters:
# * survey_code : The code of the survey to display
 def survey_code
    @survey = Survey.find(:first, :conditions => {:code => params[:code]})
    @questions = []
    
    #Only show survey if it is open
    if !@survey.nil? && @survey.privacy_level < Survey.close 
      @questions = Question.find(:all, :conditions => {:survey_id => @survey.id}, :order => 'question_number')
    end

    #respond_to do |format|
     # format.html { render :action => "index" }
    #  format.xml #survey_code.xml.builder # { render :xml => @questions }
   # end
    
    render :template => 'questions/survey_code.xml.builder', :layout => false
end


  # GET /questions/1
  # GET /questions/1.xml
  def show

    question = Question.find(params[:id])
    @survey_id = question.survey_id
    @questions = Question.find(:all, :conditions => {:survey_id => question.survey_id } );

    if has_permission(@question.survey.user)
    respond_to do |format|
      #format.html # show.html.erb
     # format.html { render :action => "index" }
     format.html { redirect_to(:controller => :questions, :action => :survey_questions, :survey_id => @survey_id ) }
     # format.html { redirect_to url_for(:controller => :questions, :action => "survey_questions", :survey_id => @question.survey_id )}
      format.xml  { render :xml => @question }
    end
    else
      render "no_permission"
    end
  end

  # GET /questions/new
  # GET /questions/new.xml
  def new
    @question = Question.new
    @survey = Survey.find(params[:survey_id])
    
    respond_to do |format|
      format.html { render :action => "new", :survey_id => params[:survey_id]}
      format.xml  { render :xml => @question }
    end
  end

  # GET /questions/1/edit
  def edit
    @question = Question.find(params[:id])
    if has_permission(@question.survey.user)
      respond_to do |format|
        format.html { render :action => "edit", :survey_id => params[:survey_id]}
      end
    else
      render "no_permission"
    end
  end

  # POST /questions
  # POST /questions.xml
  def create
    @question = Question.new(params[:question])
   
   questions = Question.find(:all, :conditions => {:survey_id => @question.survey_id})
   @question.question_number = questions.size + 1;
   
    respond_to do |format|
      if @question.save
        format.html { redirect_to(:controller => :questions, :action => :survey_questions, :survey_id => @question.survey_id ) }
        format.xml  { render :xml => @question, :status => :created, :location => @question }
      else
        format.html { render :action => "new", :survey_id => @question.survey_id }
        format.xml  { render :xml => @question.errors, :status => :unprocessable_entity }
      end
    end
  end


  # PUT /questions/1
  # PUT /questions/1.xml
  def update
    @question = Question.find(params[:id])

  if has_permission(@question.survey.user)
    respond_to do |format|
      if @question.update_attributes(params[:question])
        format.html { redirect_to(:controller => :questions, :action => :survey_questions, :survey_id => @question.survey_id ) }
	#format.html { redirect_to(:controller => :Questions, :action => :survey_questions, :notice => 'Pregunta actualizada.', :survey_id => @question.survey_id )}
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @question.errors, :status => :unprocessable_entity }
      end
    end
   else
     render "no_permissio"
   end   
   
  end

  # DELETE /questions/1
  # DELETE /questions/1.xml
  def destroy
    @question = Question.find(params[:id])
    @survey_id = @question.survey_id
    @question.destroy

    respond_to do |format|
      #format.html { redirect_to(questions_url) }
      format.html { redirect_to(:controller => :questions, :action => :survey_questions, :survey_id => @survey_id ) }
      format.xml  { head :ok }
    end
  end

  #question_id
  def move_down
  
    question = Question.find(params[:question_id])
    
    nextq = question.question_number + 1;
    next_question = Question.find(:first, :conditions => {:survey_id => question.survey_id, :question_number => nextq})
    
    if !next_question.nil?
      question.question_number = nextq
      question.save
      
      next_question.question_number = nextq -1
      next_question.save
    end
    
    redirect_to(:controller => :questions, :action => :survey_questions, :survey_id => question.survey_id ) 
  
  end
  
  #question_id
  def move_up
    question = Question.find(params[:question_id])
    
    if question.question_number > 1
      prevq = question.question_number - 1;
      prev_question = Question.find(:first, :conditions => {:survey_id => question.survey_id, :question_number => prevq})
    
      question.question_number = prevq
      question.save
      
      prev_question.question_number = prevq + 1
      prev_question.save
    end
    
    redirect_to(:controller => :questions, :action => :survey_questions, :survey_id => question.survey_id ) 
  
  end

end
