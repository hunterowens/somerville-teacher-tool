class StudentsController < ApplicationController

  before_action :authenticate_educator!

  def show
    @student = Student.find(params[:id])
    @presenter = StudentPresenter.new(@student)
    @chart_start = params[:chart_start] || "mcas-growth"
    @chart_data = StudentProfileChart.new(@student).chart_data
    @student_risk_level = @student.student_risk_level
    @level = @student_risk_level.level

    @student_school_years = @student.school_years.map do |sy|
      StudentSchoolYear.new(@student, sy)
    end

    @intervention = Intervention.new
    @interventions = @student.interventions

    @roster_url = homeroom_path(@student.homeroom)
    @csv_url = student_path(@student) + ".csv"
    @student_url = student_path(@student)

    respond_to do |format|
      format.html
      format.csv { render csv: StudentProfileCsvExporter.new(@student).profile_csv_export, filename: 'export' }
      format.pdf { render text: PDFKit.new(@student_url).to_pdf }
    end
  end

end
