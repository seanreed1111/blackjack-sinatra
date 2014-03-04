# 6 Deck, Dealer hits soft 17, Stands on 17+, double any two cards
# Player can split as much as they want, and doube after split
# no surrender


class Rules
  def initialize
  end

  def load!
    setup ={}
    setup["split_allowed"]       = true   #unlimited splits
    setup["double_down_allowed"] = true
    setup["das_allowed"]         = true

    setup["p"] = "split"
    setup["s"] = "stand"
    setup["h"] = "hit"
    setup["d"] = "double"

    #ensure that basic strategy table is set up with A represented by 1!!!
    # p = split, h = hit, d = double, s= stand
    setup["split_table"] = {}  

    setup["split_table"]["11"] = { 2=>"p",3=>"p",4=>"p",5=>"p",6=>"p",7=>"p",
                         8=>"p",9=>"p",10=>"p", 1=>"p"} 
    setup["split_table"]["22"] = {2=>"p",3=>"p",4=>"p",5=>"p",6=>"p",7=>"p",
                         8=>"h",9=>"h",10=>"h", 1=>"h"}
    setup["split_table"]["33"] = {2=>"p",3=>"p",4=>"p",5=>"p",6=>"p",7=>"p",
                         8=>"h",9=>"h",10=>"h", 1=>"h"}
    setup["split_table"]["44"] = {2=>"h",3=>"h",4=>"h",5=>"d",6=>"d",7=>"h",
                         8=>"h",9=>"h",10=>"h", 1=>"h"}
    setup["split_table"]["55"] = {2=>"d",3=>"d",4=>"d",5=>"d",6=>"d",7=>"d",
                         8=>"d",9=>"d",10=>"h", 1=>"h"}
    setup["split_table"]["66"] = {2=>"p",3=>"p",4=>"p",5=>"p",6=>"p",7=>"h",
                         8=>"h",9=>"h",10=>"h", 1=>"h"}
    setup["split_table"]["77"] = {2=>"p",3=>"p",4=>"p",5=>"p",6=>"p",7=>"p",
                         8=>"h",9=>"h",10=>"h", 1=>"h"}
    setup["split_table"]["88"] = {2=>"p",3=>"p",4=>"p",5=>"p",6=>"p",7=>"p",
                         8=>"p",9=>"p",10=>"p",1=>"p"}
    setup["split_table"]["99"] = {2=>"p",3=>"p",4=>"p",5=>"p",6=>"p",7=>"s",
                         8=>"p",9=>"p",10=>"s",1=>"s"}
    setup["split_table"]["1010"] = {2=>"s",3=>"s",4=>"s",5=>"s",6=>"s",7=>"s",
                          8=>"s",9=>"s",10=>"s",1=>"s"}


    setup["soft_hand_table"] = {}
    setup["soft_hand_table"][12] = {2=>"h",3=>"h",4=>"s", 5=>"s", 6=>"s", 7=>"h", 8=>"h", 9=>"h", 10=>"h",1=>"h"}
    setup["soft_hand_table"][13] = {2=>"h", 3=>"h", 4=>"h",5=>"d",6=>"d",7=>"h",8=>"h", 9=>"h",10=> "h",1=>"h"}
    setup["soft_hand_table"][14] = {2=>"h", 3=>"h", 4=>"h", 5=>"d", 6=>"d", 7=>"h", 8=>"h", 9=>"h", 10=>"h",1=>"h"}
    setup["soft_hand_table"][15] = {2=>"h",3=>"h",4=>"d", 5=>"d", 6=>"d", 7=>"h", 8=>"h", 9=>"h", 10=>"h",1=>"h"}
    setup["soft_hand_table"][16] = {2=>"h",3=>"h",4=>"d", 5=>"d", 6=>"d", 7=>"h", 8=>"h", 9=>"h", 10=>"h",1=>"h"}
    setup["soft_hand_table"][17] = {2=>"h",3=>"d",4=>"d", 5=>"d", 6=>"d", 7=>"h", 8=>"h", 9=>"h", 10=>"h",1=>"h"}
    setup["soft_hand_table"][18] = {2=>"d",3=>"d",4=>"d", 5=>"d", 6=>"d", 7=>"s", 8=>"s", 9=>"h", 10=>"h",1=>"h"}
    setup["soft_hand_table"][19] = {2=>"s",3=>"s",4=>"s", 5=>"s", 6=>"d", 7=>"s", 8=>"s", 9=>"s", 10=>"s",1=>"s"}
    setup["soft_hand_table"][20] = {2=>"s",3=>"s",4=>"s", 5=>"s", 6=>"s", 7=>"s", 8=>"s", 9=>"s", 10=>"s",1=>"s"}
    setup["soft_hand_table"][21] = {2=>"s",3=>"s",4=>"s", 5=>"s", 6=>"s", 7=>"s", 8=>"s", 9=>"s", 10=>"s",1=>"s"}

    setup["hard_hand_table"] = {}
    setup["hard_hand_table"][5] =   {2=>"h",3=>"h",4=>"h", 5=>"h", 6=>"h", 7=>"h", 8=>"h", 9=>"h", 10=>"h",1=>"h"}
    setup["hard_hand_table"][6] =   {2=>"h",3=>"h",4=>"h", 5=>"h", 6=>"h", 7=>"h", 8=>"h", 9=>"h", 10=>"h",1=>"h"}
    setup["hard_hand_table"][7] =   {2=>"h",3=>"h",4=>"h", 5=>"h", 6=>"h", 7=>"h", 8=>"h", 9=>"h", 10=>"h",1=>"h"}
    setup["hard_hand_table"][8] =   {2=>"h",3=>"h",4=>"h", 5=>"h", 6=>"h", 7=>"h", 8=>"h", 9=>"h", 10=>"h",1=>"h"}
    setup["hard_hand_table"][9] =   {2=>"h",3=>"d",4=>"d", 5=>"d", 6=>"d", 7=>"h", 8=>"h", 9=>"h", 10=>"h",1=>"h"}
    setup["hard_hand_table"][10] =  {2=>"d",3=>"d",4=>"d", 5=>"d", 6=>"d", 7=>"d", 8=>"d", 9=>"d", 10=>"h",1=>"h"}
    setup["hard_hand_table"][11] =  {2=>"d",3=>"d",4=>"d", 5=>"d", 6=>"d", 7=>"d", 8=>"d", 9=>"d", 10=>"d",1=>"d"}
    setup["hard_hand_table"][12] =  {2=>"h",3=>"h",4=>"s", 5=>"s", 6=>"s", 7=>"h", 8=>"h", 9=>"h", 10=>"h",1=>"h"}
    setup["hard_hand_table"][13] =  {2=>"s",3=>"s",4=>"s", 5=>"s", 6=>"s", 7=>"h", 8=>"h", 9=>"h", 10=>"h",1=>"h"}
    setup["hard_hand_table"][14] =  {2=>"s",3=>"s",4=>"s", 5=>"s", 6=>"s", 7=>"h", 8=>"h", 9=>"h", 10=>"h",1=>"h"}
    setup["hard_hand_table"][15] =  {2=>"s",3=>"s",4=>"s", 5=>"s", 6=>"s", 7=>"h", 8=>"h", 9=>"h", 10=>"h",1=>"h"}
    setup["hard_hand_table"][16] =  {2=>"s",3=>"s",4=>"s", 5=>"s", 6=>"s", 7=>"h", 8=>"h", 9=>"h", 10=>"h",1=>"h"}
    setup["hard_hand_table"][17] =  {2=>"s",3=>"s",4=>"s", 5=>"s", 6=>"s", 7=>"s", 8=>"s", 9=>"s", 10=>"s",1=>"s"}
    setup["hard_hand_table"][18] =  {2=>"s",3=>"s",4=>"s", 5=>"s", 6=>"s", 7=>"s", 8=>"s", 9=>"s", 10=>"s",1=>"s"}
    setup["hard_hand_table"][19] =  {2=>"s",3=>"s",4=>"s", 5=>"s", 6=>"s", 7=>"s", 8=>"s", 9=>"s", 10=>"s",1=>"s"}
    setup["hard_hand_table"][20] =  {2=>"s",3=>"s",4=>"s", 5=>"s", 6=>"s", 7=>"s", 8=>"s", 9=>"s", 10=>"s",1=>"s"}
    setup["hard_hand_table"][21] =  {2=>"s",3=>"s",4=>"s", 5=>"s", 6=>"s", 7=>"s", 8=>"s", 9=>"s", 10=>"s",1=>"s"}

    setup
  end
end