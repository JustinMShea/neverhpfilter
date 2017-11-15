#' Fisher Transform Nominal time series to Real
#'
#' Wrapper function calculates Fisher price index and applies it to an xts object
#'
#' \code{Fisher(Nominal, price, quantity, baseYear=250)}
#'
#'@param Nominal xts object containing the names of the prices index.
#'
#'@param price	 Vector that containing the prices index.
#'
#'@param quantity Vector that contains the quantities index.
#'
#'@param baseYear The base period(s) to calculate the indices, corresponding to
#'              the row, or observation number of the series.
#'              baseYear default period is 250 for Q2 2009.
#'
#'@examples
#'\dontrun{
#' Real_PCE <- Fisher(PCE, PCE_Price, PCE_Quanity, 249)
#'}
#'@export
Fisher <- function(Nominal, price, quantity, baseYear=249) {

        # price = price index
        # quantity = quantity index
        # base = base default period is 249 for Q1 2009.
        # Merge Price and Quantity XTS objects
        QuantityPrice <- merge(price, quantity)

        # Extract data frame for using priceIndex function
        QuantityPriceDF <- data.frame(zoo::coredata(QuantityPrice))
        colnames(QuantityPriceDF) <- c("PRICE","QUANTITY")

        # Now, call priceIndex() and set the method to "Fisher". ##
        FisherTransform <- micEconIndex::priceIndex("PRICE", "QUANTITY", base=baseYear, data=QuantityPriceDF, method="Fisher")

        # Calculate Real GDP
        # Nominal = the nominal component series
        Real_component <- merge(Nominal/FisherTransform)
        return(Real_component)
}
