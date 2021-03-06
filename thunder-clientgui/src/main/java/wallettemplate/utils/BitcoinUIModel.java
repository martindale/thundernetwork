package wallettemplate.utils;

import network.thunder.client.api.*;

import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.scene.Node;
import javafx.scene.control.Label;
import network.thunder.client.database.objects.Payment;
import org.bitcoinj.core.*;
import javafx.application.Platform;
import javafx.beans.property.ReadOnlyDoubleProperty;
import javafx.beans.property.ReadOnlyObjectProperty;
import javafx.beans.property.SimpleDoubleProperty;
import javafx.beans.property.SimpleObjectProperty;
import wallettemplate.Main;
import wallettemplate.MainController;
import wallettemplate.controls.NotificationBarPane;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Date;

import static wallettemplate.Main.bitcoin;

/**
 * A class that exposes relevant bitcoin stuff as JavaFX bindable properties.
 */
public class BitcoinUIModel {
    private SimpleObjectProperty<Address> address = new SimpleObjectProperty<>();
    private SimpleObjectProperty<Coin> balance = new SimpleObjectProperty<>(Coin.ZERO);
    public static SimpleDoubleProperty syncProgress = new SimpleDoubleProperty(-1);
    private ProgressBarUpdater syncProgressUpdater = new ProgressBarUpdater();

    private ObservableList<Transaction> transactions = FXCollections.observableArrayList();



    private ObservableList<Node> transactionsThunderIncluded = FXCollections.observableArrayList();
    private ObservableList<Node> transactionsThunderSettled = FXCollections.observableArrayList();
    private ObservableList<Node> transactionsThunderRefunded = FXCollections.observableArrayList();
    private ObservableList<Node> transactionsThunderOpen = FXCollections.observableArrayList();

    public BitcoinUIModel() {
    }

    public BitcoinUIModel(Wallet wallet) {
        setWallet(wallet);
    }

    public void setWallet(Wallet wallet) {
        wallet.addEventListener(new AbstractWalletEventListener() {
            @Override
            public void onWalletChanged(Wallet wallet) {
                super.onWalletChanged(wallet);
                update(wallet);
            }
        }, Platform::runLater);

        ThunderContext.addListener(new ThunderContext.ChangeListener() {
            @Override
            public void channelListChanged() {
                update(wallet);
            }
        });

        ThunderContext.setProgressUpdateListener(new ThunderContext.ProgressUpdateListener() {
            @Override
            public void progressUpdated(int count, int max) {

                if(max == count) {
                    Platform.runLater(() -> {
                        syncProgress.set(1.0);
                        System.out.println("Hide notification bar");

                        NotificationBarPane.Item item = Main.instance.notificationBar.getItem();

                        if (item != null) {
                            item.cancel();
                            item = null;
                        }

                    });

                } else {
                    double pct = ((double) count) / ((double) max);
                    Platform.runLater(() -> syncProgress.set(pct));
                }
            }
        });


        update(wallet);
    }

    private void update(Wallet wallet) {
        Platform.runLater(() -> {
            balance.set(wallet.getBalance(Wallet.BalanceType.AVAILABLE_SPENDABLE));
            address.set(wallet.currentReceiveAddress());
            transactions.setAll(wallet.getTransactionsByTime());

            ObservableList<Node> items1 = FXCollections.observableArrayList();
            for (Payment p : ThunderContext.getPaymentListIncluded()) {
                Label label = new Label(p.toString());
                items1.add(label);
            }
            transactionsThunderIncluded.setAll(items1);

            ObservableList<Node> items2 = FXCollections.observableArrayList();
            for (Payment p : ThunderContext.getPaymentListSettled()) {
                Label label = new Label(p.toString());
                items2.add(label);
            }
            transactionsThunderSettled.setAll(items2);

            ObservableList<Node> items3 = FXCollections.observableArrayList();
            for (Payment p : ThunderContext.getPaymentListRefunded()) {
                Label label = new Label(p.toString());
                items3.add(label);
            }
            transactionsThunderRefunded.setAll(items3);

            ObservableList<Node> items4 = FXCollections.observableArrayList();
            for (Payment p : ThunderContext.getPaymentListOpen()) {
                Label label = new Label(p.toString());
                items4.add(label);
            }
            transactionsThunderOpen.setAll(items4);
        });
    }

    private class ProgressBarUpdater extends DownloadProgressTracker {
        @Override
        protected void progress(double pct, int blocksLeft, Date date) {
            super.progress(pct, blocksLeft, date);
            Platform.runLater(() -> syncProgress.set(pct / 100.0));
        }

        @Override
        protected void doneDownload() {
            super.doneDownload();

                Platform.runLater(() -> {
                    try {
                        syncProgress.set(1.0);
                        ThunderContext.init(bitcoin.wallet(), bitcoin.peerGroup(), Main.CLIENTID);
                    } catch (SQLException e) {
                        e.printStackTrace();
                    } catch (IOException e) {
                        e.printStackTrace();
                    } catch (ClassNotFoundException e) {
                        e.printStackTrace();
                    } catch (InstantiationException e) {
                        e.printStackTrace();
                    } catch (IllegalAccessException e) {
                        e.printStackTrace();
                    }
                });

        }
    }

    public DownloadProgressTracker getDownloadProgressTracker() { return syncProgressUpdater; }

    public ReadOnlyDoubleProperty syncProgressProperty() { return syncProgress; }

    public ReadOnlyObjectProperty<Address> addressProperty() {
        return address;
    }

    public ReadOnlyObjectProperty<Coin> balanceProperty() {
        return balance;
    }

    public ObservableList<Transaction> getTransactions() {
        return transactions;
    }

    public ObservableList<Node> getTransactionsThunderIncluded() {
        return transactionsThunderIncluded;
    }

    public ObservableList<Node> getTransactionsThunderSettled() {
        return transactionsThunderSettled;
    }

    public ObservableList<Node> getTransactionsThunderRefunded() {
        return transactionsThunderRefunded;
    }

    public ObservableList<Node> getTransactionsThunderOpen() {
        return transactionsThunderOpen;
    }
}
